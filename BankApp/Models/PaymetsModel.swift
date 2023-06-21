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
        Payments(titel: "Bank transfer", image: "rublesign.circle", color: "blue"),
        Payments(titel: "SWIFT transfer", image: "globe", color: "blue")
    ]
    
    static let payments = [
        Payments(titel: "Phone bills", image: "menucard", color: "purple"),
        Payments(titel: "Housing", image: "house.circle", color: "purple"),
        Payments(titel: "Internet", image: "wifi.circle", color: "purple"),
        Payments(titel: "Education", image: "studentdesk", color: "purple"),
        Payments(titel: "Transport", image: "tram.circle", color: "purple")
    ]
    
    static let other = [
        Payments(titel: "ATM", image: "banknote", color: "purpleBlue"),
        Payments(titel: "Money request", image: "arrow.uturn.down.circle", color: "purpleBlue")
    ]
}
