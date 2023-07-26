//
//  BalanceManager.swift
//  BankApp
//
//  Created by Buba on 26.07.2023.
//

import Foundation

final class BalanceManager {
    static let shared = BalanceManager()
    
    private init() {}
    
    func calculateTotalBalance(user: User) -> Int {
        var totalBalance = 0
        for card in user.cards {
            totalBalance += card.balance
        }
        return totalBalance
    }
}
