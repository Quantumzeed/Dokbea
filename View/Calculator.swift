////
////  Calculator.swift
////  dokbea
////
////  Created by Quantum on 7/3/2566 BE.
////
//
//import SwiftUI
//
//struct Loan {
//    let principal: Double
//    let interestRate: Double
//    let loanTerm: Int
//    var monthlyPayment: Double {
//        let r = interestRate / 1200
//        let n = loanTerm
//        let numerator = r * pow((1 + r), Double(n))
//        let denominator = pow((1 + r), Double(n)) - 1
//        return principal * numerator / denominator
//    }
//    func getPayments() -> [Payment] {
//        var payments = [Payment]()
//        var balance = principal
//        let monthlyRate = interestRate / 1200
//        let monthlyPayment = self.monthlyPayment
//        for i in 1...loanTerm {
//            let interest = balance * monthlyRate
//            let principal = monthlyPayment - interest
//            balance -= principal
//            payments.append(Payment(month: i, payment: monthlyPayment, principal: principal, interest: interest, balance: balance))
//        }
//        return payments
//    }
//}
//
//struct Payment {
//    let month: Int
//    let payment: Double
//    let principal: Double
//    let interest: Double
//    let balance: Double
//}
//
//class LoanViewModel: ObservableObject {
//    @Published var principal = ""
//    @Published var interestRate = ""
//    @Published var loanTerm = ""
//    @Published var monthlyPayment = ""
//    @Published var payments = [Payment]()
//
//    private var loan: Loan? {
//        guard let principal = Double(principal),
//              let interestRate = Double(interestRate),
//              let loanTerm = Int(loanTerm) else { return nil }
//
//        return Loan(principal: principal, interestRate: interestRate, loanTerm: loanTerm)
//    }
//
//
//    func calculatePayments() {
//        guard let loan = loan else { return }
//        let pay = loan.getPayments().first?.payment
//        monthlyPayment = String(format: "%.2f", pay ?? "0.00")
//        payments = loan.getPayments()
//    }
//
//
//}
//
//struct LoanView: View {
//    @StateObject var viewModel = LoanViewModel()
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("หาภาระต่องวด")) {
//                    TextField("เงินต้น", text: $viewModel.principal)
//                        .keyboardType(.decimalPad)
//                    TextField("อัตราดอกเบี้ย", text: $viewModel.interestRate)
//                        .keyboardType(.decimalPad)
//                    TextField("ระยะเวลา (เดือน)", text: $viewModel.loanTerm)
//                        .keyboardType(.numberPad)
//                    TextField("ภาระต่อเดือน", text: $viewModel.monthlyPayment)
//                        .keyboardType(.numberPad)
//                }
//
//                Button(action: viewModel.calculatePayments) {
//                    Text("คำนวณภาระต่องวด")
//                }
//
//                if !viewModel.payments.isEmpty {
//                    Section(header: Text("Payments")) {
//                        ScrollView{
//                            ForEach(viewModel.payments, id: \.month) { payment in
//                                PaymentRow(payment: payment)
//                            }
//                        }
//
//                    }
//                }
//            }
//            .navigationBarTitle("คำนวณเงินกู้")
//
//        }
//    }
//}
//
//struct PaymentRow: View {
//    let payment: Payment
//
//    var body: some View {
//        HStack {
//            Text("\(payment.month)")
//            Spacer()
//            Text(String(format: "%.2f", payment.payment))
//            Spacer()
//            Text(String(format: "%.2f", payment.principal))
//            Spacer()
//            Text(String(format: "%.2f", payment.interest))
//            Spacer()
//            Text(String(format: "%.2f", payment.balance))
//        }
//        .font(.caption)
//    }
//}
//
//
//struct Calculator_Previews: PreviewProvider {
//    static var previews: some View {
//        LoanView()
//
//    }
//}
