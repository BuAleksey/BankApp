//
//  CardModel.swift
//  BankApp
//
//  Created by Buba on 31.05.2023.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID().uuidString
    var colors: [Color]
    
    static let colors = [
        Card(colors: [Color("purple"), Color("purpleBlue")]),
        Card(colors: [Color("blue"), Color("lightBlue")]),
        Card(colors: [Color("purpleBlue"), Color("purple")]),
        Card(colors: [Color("lightBlue"), Color("blue")])
    ]
}
