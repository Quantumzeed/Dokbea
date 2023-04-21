//
//  LoanCalculator.swift
//  dokbea
//
//  Created by Quantum on 9/3/2566 BE.
//

import SwiftUI

struct LoanModel {
    let principal: Double
    let interestRate: Double
    let loanTerm: Int
    let monthlyPayment: Double
}

struct PaymentModel {
    let month: Int
    let payment: Double
    let principal: Double
    let interest: Double
    let balance: Double
}

class LoanViewModel: ObservableObject {
    @Published var principal = ""
    @Published var interestRate = ""
    @Published var loanTerm = ""
    @Published var monthlyPayment = ""
    @Published var payments = [PaymentModel]()
    @Published var totalInterest = ""
    
    func getMonthlyPayment(){
        let r = (Double(interestRate) ?? 0) / 1200
        let n = (Int(loanTerm) ?? 0)
        let numerator = r * pow((1 + r), Double(n))
        let denominator = pow((1 + r), Double(n)) - 1
        let result = (Double(principal) ?? 0) * numerator / denominator
        if result >= 1 {
            self.monthlyPayment = String(format: "%.2f",result)
        }
    }
    
    func getLoanTerm(){
        let r = (Double(interestRate) ?? 0) / 1200
        let denominator = round(-log((1-((Double(principal) ?? 0) * r) / (Double(self.monthlyPayment) ?? 0))) / (log(1+r)))
        if denominator >= 1 {
            self.loanTerm = String(format: "%.0f",denominator)
        }
    }
    
    func getPayments() -> [PaymentModel] {
        self.payments = []
        
        guard let principal = Double(principal),
              let interestRate = Double(interestRate),
              let loanTerm = Int(loanTerm),
              let Payment = Double(monthlyPayment) else { return [] }
        
//        var payments = [PaymentModel]()
        self.totalInterest = ""
        var totalInterest : Double = 0.0
        var balance = principal
        let monthlyRate = interestRate / 1200
        let monthlyPayment = Payment
        for i in 1...loanTerm {
            let interest = balance * monthlyRate
            let principal = monthlyPayment - interest
            balance -= principal
            self.payments.append(PaymentModel(month: i, payment: monthlyPayment, principal: principal, interest: interest, balance: balance))
            totalInterest += interest
        }
        self.totalInterest = String(format: "%.0f",totalInterest)
        return self.payments
    }
}


struct LoanCalculator: View {
    @StateObject var vm = LoanViewModel()
    @State var ShowResult :Bool = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{

                    Section(header: Text("หาภาระต่องวด")) {
                        TextField("ยอดจัด", text: $vm.principal)
                        TextField("อัตราดอกเบี้ยต่อปี", text: $vm.interestRate)
                        TextField("ระยะเวลา", text: $vm.loanTerm)
                            .onSubmit {
                                vm.getMonthlyPayment()
                                _ = vm.getPayments()
                                
                                if vm.payments.isEmpty {
                                    ShowResult = false
                                }else {
                                    ShowResult = true
                                }
                            }
                        TextField("ภาระต่องวด", text: $vm.monthlyPayment)
                            .onSubmit {
                                vm.getLoanTerm()
                                _ = vm.getPayments()
                                if vm.payments.isEmpty {
                                    ShowResult = false
                                }else {
                                    ShowResult = true
                                }
                            }
                    }
                    if !vm.totalInterest.isEmpty {
                        Section("รวมดอกเบี้ยทั้งหมด") {
                            Text(vm.totalInterest)
                        }
                    }
                    
                }
                .sheet(isPresented: $ShowResult ) {
                    
                } content: {
                    
                    VStack{
                        Text("รวมดอกเบี้ยทั้งหมด \(vm.totalInterest) ")
                        ForEach(vm.payments, id: \.month) { payment in
                            PaymentRow(payment: payment)
                        }
                    }
                    
                }
                
                
                

//                if !vm.payments.isEmpty {
//                        ScrollView{
//                            ForEach(vm.payments, id: \.month) { payment in
//                                PaymentRow(payment: payment)
//                            }
//                        }
//                }
            }
            .background(
                Color.red
            )
            .navigationBarTitle("คำนวณสินเชื่อ")
        }
        
    }
    
}

struct PaymentRow: View {
    let payment: PaymentModel

    var body: some View {
        HStack {
            Text("\(payment.month)")
            Spacer()
            Text(String(format: "%.2f", payment.payment))
            Spacer()
            Text(String(format: "%.2f", payment.principal))
            Spacer()
            Text(String(format: "%.2f", payment.interest))
            Spacer()
            Text(String(format: "%.2f", payment.balance))
        }
        .font(.caption)
        .padding(.horizontal)
    }
}

struct LoanCalculator_Previews: PreviewProvider {
    static var previews: some View {
        LoanCalculator()
//        PaymentRow(payment:PaymentModel(month: 11, payment: 111, principal: 111, interest: 111, balance: 111))
    }
}
