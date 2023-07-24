//
//  SendView.swift
//  BankApp
//
//  Created by Buba on 12.06.2023.
//

import SwiftUI

struct SendView: View {
    @State private var payments = ""
    @State private var phone = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Payments")
                    
                    Spacer()
                    
                    Image(systemName: "qrcode.viewfinder")
                        .foregroundColor(.blue)
                }
                .font(.system(.title, design: .rounded, weight: .bold))
                .padding(.trailing)
                
                TextField("Payments", text: $payments)
                    .textFieldStyle(GradientTextField(image: "magnifyingglass"))
                    .padding(.trailing)
                    .padding(.bottom, 30)
                
                Text("Transfer by phone")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                
                TextField("Enter name or phone number", text: $phone)
                    .textFieldStyle(GradientTextField(image: "phone"))
                    .padding(.trailing)
                    .padding(.bottom, 30)
                
                Text("Transfers")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Payments.transfers) { payments in
                            PaymentsView(color: payments.color, text: payments.titel, image: payments.image)
                        }
                    }
                }
                .padding(.bottom, 30)
                
                Text("Payments")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Payments.payments) { payments in
                            PaymentsView(color: payments.color, text: payments.titel, image: payments.image)
                        }
                    }
                }
                .padding(.bottom, 30)
                
                Text("Other")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Payments.other) { payments in
                            PaymentsView(color: payments.color, text: payments.titel, image: payments.image)
                        }
                    }
                }
            }
            .padding([.leading, .top])
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(.gray.opacity(0.05))
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
