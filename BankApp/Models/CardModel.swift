//
//  CardModel.swift
//  BankApp
//
//  Created by Buba on 31.05.2023.
//

import Foundation

struct Card: Identifiable {
    let id = UUID().uuidString
    let number = generateCardNumber()
    let currency: Currency
    let paymentSystem: PaymentSystem
    var balance: Double = 0
    
    static let defaultCard = Card(currency: .rub, paymentSystem: .mir)
    
    static var cards = [
        Card(currency: .rub, paymentSystem: .mir, balance: 12456.40),
        Card(currency: .usd, paymentSystem: .masterCard, balance: 345),
        Card(currency: .euro, paymentSystem: .visa, balance: 23.12),
        Card(currency: .yuan, paymentSystem: .unionPay)
    ].shuffled()
    
    private static func generateCardNumber() -> String {
        let randomNumber = arc4random_uniform(9000) + 1000
        return "• " + String(randomNumber)
    }
}

enum PaymentSystem: String, CaseIterable {
    case mir, masterCard, visa, unionPay
}

enum Currency: String, CaseIterable {
    case rub, usd, euro, yuan
}
