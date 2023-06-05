//
//  CategoryModel.swift
//  BankApp
//
//  Created by Buba on 01.06.2023.
//

import Foundation

struct Category: Identifiable {
    let id = UUID().uuidString
    let title: String
    let color: String
    let percent: Int
    
    static let categorys = [
        Category(title: "Goods", color: "purple", percent: 45),
        Category(title: "Transport", color: "blue", percent: 30),
        Category(title: "Education", color: "purpleBlue", percent: 15),
        Category(title: "Other", color: "lightBlue", percent: 10)
    ]
}
