//
//  CardToCardView.swift
//  BankApp
//
//  Created by Buba on 27.07.2023.
//

import SwiftUI
import Combine

struct CardToCardView: View {
    @Binding var user: User
    @Binding var showView: Bool
    
    @State private var sendersCard = ""
    @State private var amount = ""
    @State private var destinationCardNumber = ""
    
    @State private var showAlertAboutSearchCard = false
    @State private var showAlertAboutBalance = false
    @State private var showAlertAboutCardDestination = false
    
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
                    .font(.title2)
                    .fontWeight(.bold)
                
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
                .padding([.bottom, .top], 30)
                
                TextField("Enter card's number...", text: $destinationCardNumber)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Amount...", text: $amount)
                    .textFieldStyle(.roundedBorder)
                    .padding(.bottom, 30)
                
                CustomButton(action: transfer, title: "Transfer")
                    .alert(
                        "Please choose the card",
                        isPresented: $showAlertAboutSearchCard,
                        actions: {}
                    )
                    .alert(
                        "Еhe amount entered is incorrect",
                        isPresented: $showAlertAboutBalance,
                        actions: {}
                    )
                    .alert("Еhe destination card number is specified incorrectly",
                           isPresented: $showAlertAboutCardDestination,
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
        guard var foundCard = checkingDetails.cardSearch(user: user, number: sendersCard) else {
            showAlertAboutSearchCard.toggle()
            return
        }
        
        if !checkingDetails.checkingDestinationCardNumber(number: destinationCardNumber) {
            showAlertAboutCardDestination.toggle()
            return
        }
        
        if !checkingDetails.checkingAmount(amount: amount, card: foundCard) {
            showAlertAboutBalance.toggle()
            return
        }
        
        transaction.transferCardToCard(card: &foundCard, amount: Double(amount)!)
        showView.toggle()
        print(foundCard.balance)
    }
}

struct CardToCardView_Previews: PreviewProvider {
    static var previews: some View {
        CardToCardView(
            user: .constant(User.defaultUser),
            showView: .constant(true)
        )
    }
}
