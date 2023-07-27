//
//  SendView.swift
//  BankApp
//
//  Created by Buba on 12.06.2023.
//

import SwiftUI

struct SendView: View {
    @State private var selectedTransfer = ""
    
    var body: some View {
        
        ZStack{
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea(.all)
            
            if selectedTransfer == "" {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("Transfers")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Payments.transfers) { payments in
                                    PaymentsView(
                                        color: payments.color,
                                        text: payments.titel,
                                        image: payments.image,
                                        action: {
                                            withAnimation() {
                                                selectedTransfer = payments.titel
                                            }
                                        })
                                }
                            }
                            .padding(.trailing)
                        }
                        .padding(.bottom, 30)
                        
                        Text("Payments")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Payments.payments) { payments in
                                    PaymentsView(color: payments.color, text: payments.titel, image: payments.image, action: {})
                                }
                            }
                            .padding(.trailing)
                        }
                        .padding(.bottom, 30)
                        
                        Text("Other")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Payments.other) { payments in
                                    PaymentsView(color: payments.color, text: payments.titel, image: payments.image, action: {})
                                }
                            }
                            .padding(.trailing)
                        }
                        .padding(.bottom, 120)
                    }
                    .padding([.leading, .top])
                }
                .toolbar(.hidden)
                .toolbar(.hidden, for: .tabBar)
                .edgesIgnoringSafeArea(.bottom)
            }
            
            if selectedTransfer == "Card to card" {
                CardToCardView(selectedTransfer: $selectedTransfer)
            }
            
            if selectedTransfer == "Between\naccounts" {
                BetweenAccountsView(selectedTransfer: $selectedTransfer)
            }
            
            if selectedTransfer == "Bank transfer" {
                BankTransferView(selectedTransfer: $selectedTransfer)
            }
            
            if selectedTransfer == "SWIFT transfer" {
                SwiftTransferView(selectedTransfer: $selectedTransfer)
            }
        }
    }
    
    private func router() {
        
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView()
    }
}
