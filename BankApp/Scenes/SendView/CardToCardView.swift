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
    
    @State private var selectionCard = 0
    @State private var amount = ""
    @State private var destinationCardNumber = ""
    
    @State private var showAlertAboutSearchCard = false
    @State private var showAlertAboutBalance = false
    @State private var showAlertAboutCardDestination = false
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
                
                TabView(selection: $selectionCard) {
                    ForEach(user.cards, id: \.number) { card in
                        CardView(card: card)
                            .tag(card.id)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 240)
                .onAppear {
                    selectionCard = user.cards.first?.id ?? 0
                }
                
                TextField("Destination card number", text: $destinationCardNumber)
                    .textFieldStyle(GradientTextField())
                    .onChange(of: destinationCardNumber) { _ in
                        textFieldFormat()
                    }
                
                TextField("Amount", text: $amount)
                    .textFieldStyle(GradientTextField())
                    .padding(.bottom, 20)
                
                CustomButton(action: transfer, title: "Transfer")
                    .alert(
                        "Please choose the card",
                        isPresented: $showAlertAboutSearchCard,
                        actions: {}
                    )
                    .alert(
                        "The amount entered is incorrect",
                        isPresented: $showAlertAboutBalance,
                        actions: {}
                    )
                    .alert("The destination card number is specified incorrectly",
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
        
        guard let foundCard = checkingDetails.cardSearch(
            user: user,
            id: selectionCard
        ) else {
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
        
        withAnimation { blur.toggle() }
        withAnimation(.easeIn(duration: 0.7)) { transferIsComplete.toggle() }
        
        transaction.transferCardToCard(
            user: &user,
            sendersCard: foundCard,
            amount: Double(amount)!
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showView.toggle()
        }
    }
    
    private func textFieldFormat() {
        var textWithoutWhitespace = 0
        for character in destinationCardNumber {
            if character != " " {
                textWithoutWhitespace += 1
                if textWithoutWhitespace > 16 {
                    destinationCardNumber = String(destinationCardNumber.prefix(16))
                }
            }
        }
        // TODO: split text on bloks
    }
}

struct CardToCardView_Previews: PreviewProvider {
    static var previews: some View {
        CardToCardView(
            user: .constant(DataBase.defaultUser),
            showView: .constant(true)
        )
    }
}
