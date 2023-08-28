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
    @State private var blur = false
    
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
                        CardInfoView(text: "From", card: card)
                            .tag(card.id)
                    }
                }
                .tabViewStyle(.page)
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
                .frame(height: 100)
                
                TabView(selection: $selectionDestinationCard) {
                    ForEach(destinationCards, id: \.number) { card in
                        CardInfoView(text: "To", card: card)
                            .tag(card.id)
                    }
                }
                .tabViewStyle(.page)
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
                .frame(height: 100)
                
                TextField("Amount", text: $amount)
                    .textFieldStyle(GradientTextField())
                    .padding(.bottom)
                
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
            .zIndex(1)
            .padding()
            
            if blur {
                VisualBlurEffect(uiVisualEffect: UIBlurEffect(
                    style: .systemUltraThinMaterial
                ))
                .ignoresSafeArea()
                .zIndex(2)
            }
            
            if transferIsComplete {
                Image(systemName: "checkmark.seal")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
                    .padding(.bottom, 20)
                    .zIndex(3)
            }
        }
        .keyboardType(.decimalPad)
    }
    
    private func transfer() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
        
        guard let foundSendersCard = checkingDetails.cardSearch(
            user: user,
            id: selectionSenderCard
        ) else {
            showAlertAboutCardChoosing.toggle()
            return
        }
        
        guard let foundDestinationCard = checkingDetails.cardSearch(
            user: user,
            id: selectionDestinationCard
        ) else {
            showAlertAboutCardChoosing.toggle()
            return
        }
        
        if checkingDetails.checkingAmount(amount: amount, card: foundSendersCard) {
            withAnimation { blur.toggle() }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeIn(duration: 0.9)) { transferIsComplete.toggle() }
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
        } else {
            showAlertAboutBalance.toggle()
        }
    }
}

struct BetweenAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        BetweenAccountsView(
            user: .constant(DataBase.shared.defaultUser),
            showView: .constant(true)
        )
    }
}
