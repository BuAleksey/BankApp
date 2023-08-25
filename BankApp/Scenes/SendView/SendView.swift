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
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea(.all)
                    VStack(alignment: .leading) {
                        Text("Transfers")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .padding(.leading)
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
                                BetweenAccountsView(
                                    user: $user,
                                    showView: $showBetweenAccountsView
                                )
                            }
                            .sheet(isPresented: $showBankTransferView) {
                                BankTransferView(
                                    user: $user,
                                    showView: $showBankTransferView
                                )
                            }
                            .padding([.leading,.trailing])
                        }
                        .padding(.bottom)
                        
                        Text("Other")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .padding(.leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Payments.payments) { payments in
                                    PaymentsView(
                                        color: payments.color,
                                        text: payments.titel,
                                        image: payments.image,
                                        action: {}
                                    )
                                }
                            }
                            .padding([.leading,.trailing])
                        }
                        .padding(.bottom)
                        
                        Text("Other")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .padding(.leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(Payments.other) { payments in
                                    PaymentsView(
                                        color: payments.color,
                                        text: payments.titel,
                                        image: payments.image,
                                        action: {}
                                    )
                                }
                            }
                            .padding([.leading,.trailing])
                        }
                        Spacer()
                    }
                    .padding(.top)
                }
                .toolbar(.hidden)
    }
    
    private func router(_ paymentsTitile: String) {
        switch paymentsTitile {
        case "Card to card": showCardToCardView.toggle()
        case "Between\naccounts": showBetweenAccountsView.toggle()
        case "Bank transfer": showBankTransferView.toggle()
        default:
            print("Error on SendView")
            return
        }
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        SendView(user: .constant(DataBase.defaultUser))
    }
}
