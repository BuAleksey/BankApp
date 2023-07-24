//
//  CardModel.swift
//  BankApp
//
//  Created by Buba on 31.05.2023.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID().uuidString
    let colors = [Color("blue"), Color("lightBlue")]
    let number = generateCardNumber()
    let currency: Currency
    let paymentSystem: PaymentSystem
    
    static var cards = [
        Card(
            currency: .rub,
            paymentSystem: .mir
        ),
        Card(
            currency: .usd,
            paymentSystem: .masterCard
        ),
        Card(
            currency: .euro,
            paymentSystem: .visa
        ),
        Card(
            currency: .yuan,
            paymentSystem: .unionPay
        )
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
