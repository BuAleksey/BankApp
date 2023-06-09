//
//  CardView.swift
//  BankApp
//
//  Created by Buba on 31.05.2023.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("BankName")
                    .font(.system(size: 19, weight: .semibold, design: .default))
                    .foregroundColor(.accentColor)
                
                Spacer()
                
                HStack {
                    Text(card.number)
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(.accentColor)
                    
                    Text(card.currency)
                    
                    Spacer()
                    
                    Image(card.paymentSystem.rawValue)
                }
            }
            .padding()
        }
        .frame(width: 242, height: 153)
        .background(LinearGradient(colors: card.colors, startPoint: .leading, endPoint: .trailing))
        .cornerRadius(15)
        .shadow(color: .accentColor.opacity(0.2), radius: 5, x: 4, y: 4)
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(colors: [Color("purple"), Color("purpleBlue")], number: "• 5013", currency: "₽", paymentSystem: .mir))
    }
}
