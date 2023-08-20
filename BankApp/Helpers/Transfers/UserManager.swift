//
//  UserManager.swift
//  BankApp
//
//  Created by Buba on 20.08.2023.
//

import Foundation

final class UserManager {
    static let shared = UserManager()
    
    private init() {}
    
    func createUser(name: String, password: String) -> User {
        let user = User(name: name, password: password, cards: DataBase.cards)
        return user
    }
}
