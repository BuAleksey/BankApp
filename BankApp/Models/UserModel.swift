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
    let image: String
    
    static let user = User(name: "Alex", image: "human")
}
