//
//  CardView.swift
//  BankApp
//
//  Created by Buba on 31.05.2023.
//

import SwiftUI

struct CardView: View {
    @State private var blur = true
    var card = DataBase.shared.defaultCard
    private let cardManager = CardManager.shared
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("BankName")
                    .font(.system(size: 19, weight: .semibold, design: .default))
                    .foregroundColor(.accentColor)
                
                Spacer()
                
                Text(card.balance.formatted())
                    .blur(radius: blur ? 5 : 0)
                    .onTapGesture {
                        blur.toggle()
                    }
                
                Spacer()
                
                HStack {
                    Text("• \(card.number)")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(.accentColor)
                    Text(card.currency.symbol)
                    Spacer()
                    Image(card.paymentSystem.rawValue)
                }
            }
            .padding()
        }
        .frame(width: 242, height: 153)
        .background(LinearGradient(
            colors: [Color("blue"), Color("lightBlue")],
            startPoint: .leading,
            endPoint: .trailing
        ))
        .cornerRadius(15)
        .shadow(color: .accentColor.opacity(0.2), radius: 5, x: 4, y: 4)
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: DataBase.shared.defaultCard)
    }
}
