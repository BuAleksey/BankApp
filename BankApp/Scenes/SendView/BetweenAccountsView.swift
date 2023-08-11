//
//  BetweenAccountsView.swift
//  BankApp
//
//  Created by Buba on 27.07.2023.
//

import SwiftUI

struct BetweenAccountsView: View {
    @Binding var user: User
    @Binding var showView: Bool
    
    @State private var sendersCard = ""
    @State private var amount = ""
    @State private var destinationCard = ""
    @State private var destinationCards: [Card] = []
    
    @State private var showAlertAboutCardChoosing = false
    @State private var showAlertAboutBalance = false
    @State private var transferIsComplete = false
    
    private let cardManager = CardManager.shared
    private let transaction = Transactions.shared
    private let checkingDetails = CheckingDetails.shared
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea()
            
            VStack {
                Picker("Select card", selection: $sendersCard) {
                    ForEach(user.cards, id: \.number) { card in
                        Text(
                            cardManager.generateCurrencySymbol(
                                card.currency
                            )
                            +
                            " • "
                            +
                            card.number
                        )
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom)
                .onChange(of: sendersCard) { _ in
                    guard let foundCard = checkingDetails.cardSearch(
                        user: user,
                        number: sendersCard
                    ) else { return }
                    destinationCards = user.cards
                    for (index, card) in user.cards.enumerated() {
                        if card.id == foundCard.id {
                            destinationCards.remove(at: index)
                        }
                    }
                }
                
                if sendersCard == "" {
                    Picker("Select card", selection: $destinationCard) {
                        ForEach(user.cards, id: \.number) { card in
                            Text(
                                cardManager.generateCurrencySymbol(
                                    card.currency
                                )
                                +
                                " • "
                                +
                                card.number
                            )
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.bottom)
                } else {
                    Picker("Select card", selection: $destinationCard) {
                        ForEach(destinationCards, id: \.number) { card in
                            Text(
                                cardManager.generateCurrencySymbol(
                                    card.currency
                                )
                                +
                                " • "
                                +
                                card.number
                            )
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.bottom)
                }
                
                TextField("Amount...", text: $amount)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom)
                
                Image(systemName: transferIsComplete ? "checkmark.seal" : "")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
                    .padding(.bottom, 30)
                
                CustomButton(action: transfer, title: "Transfer")
                    .alert(
                        "Please choose the card",
                        isPresented: $showAlertAboutCardChoosing,
                        actions: {}
                    )
                    .alert(
                        "Еhe amount entered is incorrect",
                        isPresented: $showAlertAboutBalance,
                        actions: {}
                    )
                
                Button(action: { showView.toggle() }) {
                    Text("Cancel")
                        .foregroundColor(Color.accentColor)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                }
                .frame(width: 300, height: 50)
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func transfer() {
        guard let foundSendersCard = checkingDetails.cardSearch(user: user, number: sendersCard) else {
            showAlertAboutCardChoosing.toggle()
            return
        }
        
        guard let foundDestinationCard = checkingDetails.cardSearch(user: user, number: destinationCard) else {
            showAlertAboutCardChoosing.toggle()
            return
        }
        
        if !checkingDetails.checkingAmount(amount: amount, card: foundSendersCard) {
            showAlertAboutBalance.toggle()
        }
        
        withAnimation(.easeIn(duration: 0.7)) {
            transferIsComplete.toggle()
        }
        
        transaction.transferBetweenAccounts(
            user: &user,
            sendersCard: foundSendersCard,
            destinationCard: foundDestinationCard,
            amount: Double(amount)!
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showView.toggle()
        }
    }
}

struct BetweenAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        BetweenAccountsView(user: .constant(.defaultUser), showView: .constant(true))
    }
}
