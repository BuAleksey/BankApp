//
//  CardManager.swift
//  BankApp
//
//  Created by Buba on 03.08.2023.
//

import Foundation

final class CardManager {
    static let shared = CardManager()
    
    private init() {}
    
    func addNewCard(user: inout User, currency: String, paymentSystem: String) {
        let card = generateCard(
            currency: currency,
            paymentSystem: paymentSystem
        )
        user.cards.append(card)
    }
    
    func generateCard(currency: String, paymentSystem: String) -> Card {
        let card = Card(
            currency: generateСurrency(currency),
            paymentSystem: generatePaymentSystem(paymentSystem)
        )
        return card
    }
    
    func generateСurrency(_ currency: String) -> Currency {
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
    
    func generatePaymentSystem(_ paymentSystem: String) -> PaymentSystem {
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
    
    func generateCurrencySymbol(_ currency: Currency) -> String {
        switch currency {
        case .rub:
            return "₽"
        case .usd:
            return "$"
        case .euro:
            return "€"
        case .yuan:
            return "¥"
        }
    }
}
