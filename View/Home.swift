//
//  Home.swift
//  dokbea
//
//  Created by Quantum on 29/3/2566 BE.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("ดอกเบี้ย")
                Form {
                    VStack(alignment: .leading, spacing: 20, content: {
                        NavigationLink("คำนวนเงินกู้", destination: LoanCalculator())
                    })
                }
            }
            
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
