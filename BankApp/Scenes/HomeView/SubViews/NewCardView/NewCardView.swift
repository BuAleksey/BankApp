//
//  NewCardView.swift
//  BankApp
//
//  Created by Buba on 24.07.2023.
//

import SwiftUI

struct NewCardView: View {
    @Binding var user: User
    
    @State private var paymentSystem = ""
    @State private var currency = ""
    
    @Environment (\.dismiss) var dismiss
    
    private let cardManager = CardManager.shared
    
    var body: some View {
        VStack {
            CardView(card: cardManager.generateCard(
                currency: currency,
                paymentSystem: paymentSystem
            ))
            
            Spacer()
            
            HStack {
                Text("Payment system:")
                Spacer()
                Picker("Payment system", selection: $paymentSystem) {
                    ForEach(PaymentSystem.allCases, id: \.rawValue) { paymentSystem in
                        Text(paymentSystem.viewFormat)
                    }
                }
            }
            .font(.headline)
            
            HStack {
                Text("Currency:")
                Spacer()
                Picker("Currency", selection: $currency) {
                    ForEach(Currency.allCases, id: \.rawValue) { currency in
                        Text(currency.symbol)
                    }
                }
                .frame(width: 200)
                .pickerStyle(.segmented)
            }
            .font(.headline)
            
            Spacer()
            
            CustomButton(action: addNewCard, title: "Open card")
            
            Button(action: { dismiss() }) {
                Text("Cancel")
                    .foregroundColor(Color.accentColor)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
            }
            .frame(width: 300, height: 50)
            .cornerRadius(10)
            
            Spacer()
                .frame(height: 300)
        }
        .toolbar(.hidden)
        .padding(16)
        .background(.gray.opacity(0.05))
    }
    
    private func addNewCard() {
        cardManager.addNewCard(
            user: &user,
            currency: currency,
            paymentSystem: paymentSystem
        )
        dismiss()
    }
}

struct NewCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardView(user: .constant(DataBase.shared.defaultUser))
    }
}
