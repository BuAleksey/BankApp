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
        Card(colors: [Color("purpleColor"), Color("purpleBlueColor")]),
        Card(colors: [Color("blueColor"), Color("lightBlueColor")]),
        Card(colors: [Color("purpleBlueColor"), Color("purpleColor")]),
        Card(colors: [Color("lightBlueColor"), Color("blueColor")])
    ]
}
