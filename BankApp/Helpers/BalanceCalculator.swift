//
//  BalanceManager.swift
//  BankApp
//
//  Created by Buba on 26.07.2023.
//

import Foundation

final class BalanceCalculator {
    static let shared = BalanceCalculator()
    
    private let usd = 89.96
    private let euro = 99.6
    private let yuan = 12.58
    
    private init() {}
    
    func calculateTotalBalance(user: User) -> Double {
        var totalBalance: Double = 0
        for card in user.cards {
            switch card.currency {
            case .rub: totalBalance += card.balance
            case .usd: totalBalance += card.balance * usd
            case .euro: totalBalance += card.balance * euro
            case .yuan: totalBalance += card.balance * yuan
            }
        }
        let roundedBalance = round(totalBalance * 10) / 10
        return roundedBalance
    }
    
    func calculateWithCurrencyRate(senderCard: Card, destinationCard: Card, amount: Double) -> Double {
        switch senderCard.currency {
        case .rub:
            switch destinationCard.currency {
            case .rub:
                return amount
            case .usd:
                return amount / usd
            case .euro:
                return amount / euro
            case .yuan:
                return amount / yuan
            }
        case .usd:
            switch destinationCard.currency {
            case .rub:
                return amount * usd
            case .usd:
                return amount
            case .euro:
                return amount * usd / euro
            case .yuan:
                return amount * usd / yuan
            }
        case .euro:
            switch destinationCard.currency {
            case .rub:
                return amount * euro
            case .usd:
                return amount * euro / usd
            case .euro:
                return amount
            case .yuan:
                return amount * euro / yuan
            }
        case .yuan:
            switch destinationCard.currency {
            case .rub:
                return amount * yuan
            case .usd:
                return amount * yuan / usd
            case .euro:
                return amount * yuan / euro
            case .yuan:
                return amount
            }
        }
    }
}
