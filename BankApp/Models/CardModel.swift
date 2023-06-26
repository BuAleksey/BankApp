//
//  CardModel.swift
//  BankApp
//
//  Created by Buba on 31.05.2023.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID().uuidString
    let colors: [Color]
    let number: String
    let currency: String
    let paymentSystem: PaymentSystem
    
    static let cards = [
        Card(colors: [Color("purple"), Color("purpleBlue")], number: "• 5013", currency: "₽", paymentSystem: .mir),
        Card(colors: [Color("blue"), Color("lightBlue")], number: "• 5023", currency: "$", paymentSystem: .masterCard),
        Card(colors: [Color("purpleBlue"), Color("purple")], number: "• 5044", currency: "€", paymentSystem: .visa),
        Card(colors: [Color("lightBlue"), Color("blue")], number: "• 5053", currency: "¥", paymentSystem: .unionPay)
    ].shuffled()
}

enum PaymentSystem: String {
    case mir, masterCard, visa, unionPay
}
