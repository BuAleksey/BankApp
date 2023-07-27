//
//  NewCardView.swift
//  BankApp
//
//  Created by Buba on 24.07.2023.
//

import SwiftUI

struct NewCardView: View {
    @Binding var user: User
    
    @State private var paymentSystem = "mir"
    @State private var currency = "rub"
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            CardView(card: generateCard(
                currency: currency,
                paymentSystem: paymentSystem
            ))
            
            Spacer()
            
            HStack {
                Text("Payment system:")
                Spacer()
                Picker("Payment system", selection: $paymentSystem) {
                    ForEach(PaymentSystem.allCases, id: \.rawValue) { paymentSystem in
                        Text(paymentSystem.rawValue)
                    }
                }
            }
            .font(.headline)
            
            HStack {
                Text("Currency:")
                Spacer()
                Picker("Currency", selection: $currency) {
                    ForEach(Currency.allCases, id: \.rawValue) { currency in
                        Text(currency.rawValue)
                    }
                }
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
        let card = generateCard(currency: currency, paymentSystem: paymentSystem)
        user.cards.append(card)
        dismiss()
    }
    
    private func generateCard(currency: String, paymentSystem: String) -> Card {
        let card = Card(
            currency: generateСurrency(currency),
            paymentSystem: generatePaymentSystem(paymentSystem)
        )
        return card
    }
    
    private func generateСurrency(_ currency: String) -> Currency {
        switch currency {
        case "rub":
            return .rub
        case "usd":
            return .usd
        case "euro":
            return .euro
        case "yuan":
            return .yuan
        default:
            return .rub
        }
    }
    
    private func generatePaymentSystem(_ paymentSystem: String) -> PaymentSystem {
        switch paymentSystem {
        case "mir":
            return .mir
        case "masterCard":
            return .masterCard
        case "visa":
            return .visa
        case "unionPay":
            return .unionPay
        default:
            return .mir
        }
    }
}

struct NewCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewCardView(
            user: .constant(User(
                name: "Alex",
                password: "123",
                cards: [Card(
                    currency: .euro,
                    paymentSystem: .mir
                )]
            ))
        )
    }
}
