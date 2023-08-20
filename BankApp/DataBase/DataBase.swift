//
//  DataBase.swift
//  BankApp
//
//  Created by Buba on 20.08.2023.
//

import Foundation

final class DataBase {
    static let shared = DataBase()
    
    static let defaultUser = User(
        name: "Ignat",
        password: "12345",
        cards: [defaultCard]
    )
    
    static let defaultCard = Card(currency: .rub, paymentSystem: .mir, balance: 1000)
    
    static var cards = [
        Card(currency: .rub, paymentSystem: .mir, balance: 12456.40),
        Card(currency: .usd, paymentSystem: .masterCard, balance: 345),
        Card(currency: .euro, paymentSystem: .visa, balance: 23.12),
        Card(currency: .yuan, paymentSystem: .unionPay)
    ].shuffled()
    
    private init() {}
}
