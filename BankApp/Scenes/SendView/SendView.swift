//
//  SendView.swift
//  BankApp
//
//  Created by Buba on 12.06.2023.
//

import SwiftUI

struct SendView: View {
    @Binding var user: User
    
    @State private var showCardToCardView = false
    @State private var showBetweenAccountsView = false
    @State private var showBankTransferView = false
    @State private var showSWIFTTransferView = false
    
    var body: some View {
        
        ZStack{
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea(.all)
            
           
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
                                        action: { router(payments.titel) }
                                    )
                                }
                            }
                            .sheet(isPresented: $showCardToCardView) {
                                CardToCardView(
                                    user: $user,
                                    showView: $showCardToCardView
                                )
                            }
                            .sheet(isPresented: $showBetweenAccountsView) {
                                BetweenAccountsView()
                            }
                            .sheet(isPresented: $showBankTransferView) {
                                BankTransferView()
                            }
                            .sheet(isPresented: $showSWIFTTransferView) {
                                SwiftTransferView()
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
    }
    
    private func router(_ paymentsTitile: String) {
        switch paymentsTitile {
        case "Card to card": showCardToCardView.toggle()
        case "Between\naccounts": showBetweenAccountsView.toggle()
        case "Bank transfer": showBankTransferView.toggle()
        case "SWIFT transfer": showSWIFTTransferView.toggle()
        default:
            print("Error on SendView")
            return
        }
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView(user: .constant(User.defaultUser))
    }
}
