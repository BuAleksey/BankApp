//
//  Transfers.swift
//  BankApp
//
//  Created by Buba on 09.08.2023.
//

import Foundation

final class Transactions {
    static let shared = Transactions()
    
    private init() {}
    
    func transferCardToCard(user: inout User, sendersCard: Card, amount: Double) {
        for (index, card) in user.cards.enumerated() {
            if card.id == sendersCard.id {
                user.cards[index].balance -= amount
            }
        }
    }
}

