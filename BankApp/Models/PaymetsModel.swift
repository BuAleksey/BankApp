//
//  PaymetsModel.swift
//  BankApp
//
//  Created by Buba on 21.06.2023.
//

import Foundation

struct Payments: Identifiable {
    let id = UUID().uuidString
    let titel: String
    let image: String
    let color: String
    
    static let transfers = [
        Payments(titel: "Card to card", image: "creditcard", color: "blue"),
        Payments(titel: "Between\naccounts", image: "arrow.left.arrow.right.circle", color: "blue"),
        Payments(titel: "Bank transfer", image: "rublesign.circle", color: "blue")
    ]
    
    static let payments = [
        Payments(titel: "", image: "", color: "gray"),
        Payments(titel: "", image: "", color: "gray"),
        Payments(titel: "", image: "", color: "gray"),
        Payments(titel: "", image: "", color: "gray")
    ]
    
    static let other = [
        Payments(titel: "", image: "", color: "gray"),
        Payments(titel: "", image: "", color: "gray"),
        Payments(titel: "", image: "", color: "gray"),
        Payments(titel: "", image: "", color: "gray")
    ]
}
