//
//  PaymentSystems.swift
//  BankApp
//
//  Created by Buba on 28.08.2023.
//

import Foundation

enum PaymentSystem: String, CaseIterable {
    case mir, masterCard, visa, unionPay
    
    var viewFormat: String {
        switch self {
        case .mir:
            return "MIR"
        case .masterCard:
            return "Master card"
        case .visa:
            return "VISA"
        case .unionPay:
            return "Union pay"
        }
    }
}
