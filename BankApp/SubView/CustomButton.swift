//
//  CustomModifire.swift
//  BankApp
//
//  Created by Buba on 25.06.2023.
//

import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let title: String
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
                .frame(width: 300, height: 50)
                .background(Color.accentColor)
                .cornerRadius(10)
        }
    }
}
