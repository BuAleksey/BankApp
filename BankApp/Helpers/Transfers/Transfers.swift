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
    
    func transferBetweenAccounts(user: inout User, sendersCard: Card, destinationCard: Card, amount: Double) {
        for (index, card) in user.cards.enumerated() {
            if card.id == sendersCard.id {
                user.cards[index].balance -= amount
            } else if card.id == destinationCard.id {
                user.cards[index].balance += BalanceCalculator.shared.calculateWithCurrencyRate(
                    senderCard: sendersCard,
                    destinationCard: destinationCard,
                    amount: amount
                )
            }
        }
    }
}

