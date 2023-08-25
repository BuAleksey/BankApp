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
    
    @State private var selectionSenderCard = 0
    @State private var selectionDestinationCard = 0
    @State private var amount = ""
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
                Text("Card to card")
                    .font(.title3)
                    .fontWeight(.bold)
                
                TabView(selection: $selectionSenderCard) {
                    ForEach(user.cards, id: \.number) { card in
                        CardView(card: card)
                            .tag(card.id)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 240)
                .onAppear {
                    withAnimation {
                        selectionSenderCard = user.cards.first?.id ?? 0
                        guard let foundCard = checkingDetails.cardSearch(
                            user: user,
                            id: selectionSenderCard
                        ) else { return }
                        destinationCards = user.cards
                        for (index, card) in user.cards.enumerated() {
                            if card.id == foundCard.id {
                                    destinationCards.remove(at: index)
                            }
                        }
                    }
                }
                .onChange(of: selectionSenderCard) { _ in
                    guard let foundCard = checkingDetails.cardSearch(
                        user: user,
                        id: selectionSenderCard
                    ) else { return }
                    destinationCards = user.cards
                    for (index, card) in user.cards.enumerated() {
                        if card.id == foundCard.id {
                                destinationCards.remove(at: index)
                        }
                    }
                }
                
                TabView(selection: $selectionDestinationCard) {
                    ForEach(destinationCards, id: \.number) { card in
                        CardView(card: card)
                            .tag(card.id)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 240)
                .onAppear {
                    withAnimation {
                        selectionDestinationCard = destinationCards.first?.id ?? 0
                    }
                }
                .onChange(of: selectionSenderCard) { newValue in
                    withAnimation {
                        selectionDestinationCard = destinationCards.first?.id ?? 0
                    }
                }
                
                TextField("Amount", text: $amount)
                    .textFieldStyle(GradientTextField())
                    .padding(.bottom)
                
                Image(systemName: transferIsComplete ? "checkmark.seal" : "")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
                    .padding(.bottom, 20)
                
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
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
        
        guard let foundSendersCard = checkingDetails.cardSearch(user: user, id: selectionSenderCard) else {
            showAlertAboutCardChoosing.toggle()
            return
        }
        
        guard let foundDestinationCard = checkingDetails.cardSearch(user: user, id: selectionDestinationCard) else {
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
        BetweenAccountsView(user: .constant(DataBase.defaultUser), showView: .constant(true))
    }
}
