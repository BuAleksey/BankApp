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
    
    func checkingUsersLoginParametrs(login: String, password: String) -> Bool {
        if login != "", password != "" {
             return true
        } else {
            return false
        }
    }
    
    func cardSearch(user: User, id: Int) -> Card? {
        for card in user.cards {
            if card.id == id {
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
    
    func checkingDestinationBankInfo(bikCode: String, recipientsAccount: String) -> Bool {
        if bikCode.count == 9,  recipientsAccount.count == 20 {
            let firstPart = recipientsAccount.prefix(10)
            let secondPart = recipientsAccount.suffix(10)
            if let _ = Int(bikCode) , let _ = Int(firstPart), let _ = Int(secondPart) {
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
