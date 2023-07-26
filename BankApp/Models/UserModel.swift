//
//  UserModel.swift
//  BankApp
//
//  Created by Buba on 08.06.2023.
//

import Foundation

struct User: Identifiable {
    let id = UUID().uuidString
    let name: String
    let password: String
    var image = "human"
    var mail = "oldf@gmail.com"
    var phoneNumber = "8(903)782-12-16"
    var cards: [Card]
    
    static let defaultUser = User(name: "Ignat", password: "12345", cards: [Card.defaultCard])
}
