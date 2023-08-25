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
                return round(amount / usd * 10) / 10
            case .euro:
                return round(amount / euro * 10) / 10
            case .yuan:
                return round(amount / yuan * 10) / 10
            }
        case .usd:
            switch destinationCard.currency {
            case .rub:
                return round(amount * usd * 10) / 10
            case .usd:
                return amount
            case .euro:
                return round(amount * usd / euro * 10) / 10
            case .yuan:
                return round(amount * usd / yuan * 10) / 10
            }
        case .euro:
            switch destinationCard.currency {
            case .rub:
                return round(amount * euro * 10) / 10
            case .usd:
                return round(amount * euro / usd * 10) / 10
            case .euro:
                return amount
            case .yuan:
                return round(amount * euro / yuan * 10) / 10
            }
        case .yuan:
            switch destinationCard.currency {
            case .rub:
                return round(amount * yuan * 10) / 10
            case .usd:
                return round(amount * yuan / usd * 10) / 10
            case .euro:
                return round(amount * yuan / euro * 10) / 10
            case .yuan:
                return amount
            }
        }
    }
}
