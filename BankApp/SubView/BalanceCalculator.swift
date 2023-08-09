//
//  BalanceManager.swift
//  BankApp
//
//  Created by Buba on 26.07.2023.
//

import Foundation

final class BalanceCalculator {
    static let shared = BalanceCalculator()
    
    private init() {}
    
    func calculateTotalBalance(user: User) -> Double {
        let usd = 89.96
        let euro = 99.6
        let yuan = 12.58
        
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
    
    
}
