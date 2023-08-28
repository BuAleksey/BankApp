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
    var image: String? = nil
    let color: String
}
