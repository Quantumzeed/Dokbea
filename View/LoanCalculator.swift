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
    
    func getMonthlyPayment(){
        let r = (Double(interestRate) ?? 0) / 1200
        let n = (Int(loanTerm) ?? 0)
        let numerator = r * pow((1 + r), Double(n))
        let denominator = pow((1 + r), Double(n)) - 1
        let result = (Double(principal) ?? 0) * numerator / denominator
        if result >= 1 {
            self.monthlyPayment = String(result)
        }
        
    }
    
    func getLoanTerm(){
        let r = (Double(interestRate) ?? 0) / 1200
        let denominator = round(-log((1-((Double(principal) ?? 0) * r) / (Double(self.monthlyPayment) ?? 0))) / (log(1+r)))
        if denominator >= 1 {
            self.loanTerm = String(denominator)
        }
    }
}


struct LoanCalculator: View {
    @StateObject var vm = LoanViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                Form{

                    Section(header: Text("หาภาระต่องวด")) {
                        TextField("ยอดจัด", text: $vm.principal)
                        TextField("อัตราดอกเบี้ยต่อปี", text: $vm.interestRate)
                        TextField("ระยะเวลา", text: $vm.loanTerm)
                            .onSubmit {
                                vm.getMonthlyPayment()
                            }
                        TextField("ภาระต่องวด", text: $vm.monthlyPayment)
                            .onSubmit {
                                vm.getLoanTerm()
                            }
                    }
                }
            }
            .background(
                Color.red
            )
            .navigationBarTitle("คำนวณสินเชื่อ")
        }

    }
}

struct LoanCalculator_Previews: PreviewProvider {
    static var previews: some View {
        LoanCalculator()
    }
}
