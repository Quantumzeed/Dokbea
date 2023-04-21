////
////  MainLoan.swift
////  dokbea
////
////  Created by Quantum on 10/3/2566 BE.
////
//
//import SwiftUI
//
//struct MainLoan: View {
//    
////    init(){
////        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
////    }
//    
//    // MARK: - Properties
//    @State var principal = ""
//    @State var interestRate = ""
//    @State var loanTerm = ""
//    @State var monthlyPayment = ""
//    @State var modeLoan : ModeLoan = .FindPayment
//    
//    @State var slider : Double = 0.0
//    
//    enum ModeLoan: String , CaseIterable {
//        case FindPayment = "หาภาระต่องวด"
//        case FindTerm = "หาจำนวนงวด"
//    }
//    
//    @State var test = "aa"
//    
//    var test2 = ["aa","bb"]
//    var body: some View {
//        NavigationView{
//            VStack{
//                
//                Picker("", selection: $modeLoan) {
//                    ForEach(ModeLoan.allCases , id: \.self) { item in
//                        Text(item.rawValue)
//                    }
//                }
//                .onChange(of: modeLoan, perform: { newValue in
//                    modeLoan == .FindPayment ? (monthlyPayment = "") : (loanTerm = "")
//                })
//                .pickerStyle(.segmented)
//                TextField("ยอดจัด", text: $principal)
//                    .textFieldStyle(CustomTextFieldStyle())
//                HStack {
//                    TextField("อัตราดอกเบี้ยต่อปี", text: $interestRate)
//                        .textFieldStyle(CustomTextFieldStyle())
//                    Stepper {
//                        var cal = (Double(interestRate) ?? 0.0) + 0.5
//                        interestRate = String(cal)
//                    } onDecrement: {
//                        var cal = (Double(interestRate) ?? 0.0) - 0.5
//                        interestRate = String(cal)
//                    } onEditingChanged: { _ in
//                    } label: {
//                    }
//                }
//                
//
//                TextField("จำนวนงวด", text: $loanTerm)
//                    .textFieldStyle(CustomTextFieldStyle())
//                    .disabled(modeLoan == .FindPayment ? false : true )
//                TextField("ภาระต่องวด", text: $monthlyPayment)
//                    .textFieldStyle(CustomTextFieldStyle())
//                    .disabled(modeLoan == .FindPayment ? true : false)
//                Button {
//                    getLoan()
//                } label: {
//                    Text("คำนวณ")
//                        .font(.title2)
//                }
//                .buttonStyle(.borderedProminent)
//
//                Spacer()
//            }
//            .padding()
////            .background(
////                Color.mint.gradient.opacity(0.1)
////            )
//            
//            .navigationBarTitle("คำนวณสินเชื่อ")
//        }
//    }
//    
//    func getLoan(){
//        
//        if modeLoan == .FindPayment {
//            getMonthlyPayment()
//        } else {
//            getLoanTerm()
//        }
//        
//    }
//    
//    func getMonthlyPayment(){
//        let r = (Double(interestRate) ?? 0) / 1200
//        let n = (Int(loanTerm) ?? 0)
//        let numerator = r * pow((1 + r), Double(n))
//        let denominator = pow((1 + r), Double(n)) - 1
//        let result = round((Double(principal) ?? 0) * numerator / denominator)
//        if result >= 1 {
//            monthlyPayment = String(result)
//        }
//        
//    }
//    
//    func getLoanTerm(){
//        let r = (Double(interestRate) ?? 0) / 1200
//        let denominator = round(-log((1-((Double(principal) ?? 0) * r) / (Double(self.monthlyPayment) ?? 0))) / (log(1+r)))
//        if denominator >= 1 {
//            self.loanTerm = String(denominator)
//        }
//    }
//    
//}
//
//
//
//
//struct CustomTextFieldStyle: TextFieldStyle {
//    func _body(configuration: TextField<Self._Label>) -> some View {
//        configuration
//            .keyboardType(.numberPad)
////            .foregroundColor(.green)
////            .font(.title3)
//            .padding(8)
////            .background()
////            .cornerRadius(8)
////            .overlay {
////                RoundedRectangle(cornerRadius: 8, style: .continuous)
////                    .stroke(LinearGradient(colors: [.secondary.opacity(0.2),.secondary.opacity(0.25),.clear], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
////            }
//            
//    }
//}
//
//struct MainLoan_Previews: PreviewProvider {
//    static var previews: some View {
//        MainLoan()
//    }
//}
