//
//  ChackingDetails.swift
//  BankApp
//
//  Created by Buba on 09.08.2023.
//

import Foundation

final class CheckingDetails {
    static let shared = CheckingDetails()
    
    private init() {}
    
    func cardSearch(user: User, number: String) -> Card? {
        for card in user.cards {
            if card.number == number {
                return card
            }
        }
        return nil
    }
    
    func checkingDestinationCardNumber(number: String) -> Bool {
        if number.count == 16 {
            if let _ = Int(number) {
                return true
            }
        }
        return false
    }
    
    func checkingAmount(amount: String, card: Card) -> Bool {
        if let doubleAmount = Double(amount) {
            if doubleAmount <= card.balance {
                return true
            }
        }
        return false
    }
}
