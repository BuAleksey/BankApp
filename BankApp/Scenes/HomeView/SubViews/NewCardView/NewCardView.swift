//
//  NewCardView.swift
//  BankApp
//
//  Created by Buba on 24.07.2023.
//

import SwiftUI

struct NewCardView: View {
    @State private var paymentSystem = ""
    @State private var currency = ""
    
    var body: some View {
        VStack {
            CardView(card: Card (
                currency: generateСurrency(currency),
                paymentSystem: generatePaymentSystem(paymentSystem),
                balance: 0
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
                Picker("", selection: $currency) {
                    ForEach(Currency.allCases, id: \.rawValue) { currency in
                        Text(currency.rawValue)
                    }
                }
            }
            .font(.headline)
            
            Spacer()
            
            CustomButton(action: addNewCard, title: "Open new card")
            
            Button(action: {}) {
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
        .padding(16)
        .background(.gray.opacity(0.05))
    }
    
    private func addNewCard() {
        let card = Card(
            currency: generateСurrency(currency),
            paymentSystem: generatePaymentSystem(paymentSystem),
            balance: 0
        )
        
        Card.cards.append(card)
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
        NewCardView()
    }
}
