//
//  DataBase.swift
//  BankApp
//
//  Created by Buba on 20.08.2023.
//

import Foundation

final class DataBase {
    static let shared = DataBase()
    
    let defaultUser = User(
        name: "Ignat",
        password: "12345",
        cards: [
            Card(currency: .rub, paymentSystem: .mir, balance: 1000),
            Card(currency: .usd, paymentSystem: .masterCard, balance: 234)
        ]
    )
    
    let defaultCard = Card(currency: .rub, paymentSystem: .mir, balance: 1000)
    
    var cards = [
        Card(currency: .rub, paymentSystem: .mir, balance: 12456.40),
        Card(currency: .usd, paymentSystem: .masterCard, balance: 345),
        Card(currency: .euro, paymentSystem: .visa, balance: 23.12),
        Card(currency: .yuan, paymentSystem: .unionPay)
    ].shuffled()
    
    let transfers = [
        Payments(titel: "Card to card", image: "creditcard", color: "blue"),
        Payments(titel: "Between\naccounts", image: "arrow.left.arrow.right.circle", color: "blue"),
        Payments(titel: "Bank transfer", image: "rublesign.circle", color: "blue")
    ]
    
    let otherPayments = [
        Payments(titel: "", color: "gray"),
        Payments(titel: "", color: "gray"),
        Payments(titel: "", color: "gray"),
        Payments(titel: "", color: "gray")
    ]
    
    private init() {}
}
