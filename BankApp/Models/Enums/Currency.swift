//
//  Currensy.swift
//  BankApp
//
//  Created by Buba on 28.08.2023.
//

import Foundation

enum Currency: String, CaseIterable {
    case rub, usd, euro, yuan
    
    var symbol: String {
        switch self {
        case .rub:
            return "₽"
        case .usd:
            return "$"
        case .euro:
            return "€"
        case .yuan:
            return "¥"
        }
    }
}
