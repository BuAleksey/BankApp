//
//  CardModel.swift
//  BankApp
//
//  Created by Buba on 31.05.2023.
//

import Foundation

struct Card: Identifiable {
    let id = Int.random(in: 1...100)
    let number = generateCardNumber()
    let currency: Currency
    let paymentSystem: PaymentSystem
    var balance: Double = 0
    
    private static func generateCardNumber() -> String {
        let randomNumber = arc4random_uniform(9000) + 1000
        return String(randomNumber)
    }
}

enum PaymentSystem: String, CaseIterable {
    case mir, masterCard, visa, unionPay
}

enum Currency: String, CaseIterable {
    case rub, usd, euro, yuan
    
    var symbol: String {
        switch self {
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
