//
//  BankAccountView.swift
//  BankApp
//
//  Created by Buba on 28.07.2023.
//

import SwiftUI

struct BankAccountView: View {
    let card: Card
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("lightBlue"))
                .frame(height: 80)
            
            VStack(alignment: .leading) {
                Text("from")
                    .opacity(0.5)
                HStack {
                    Text(card.balance.formatted())
                    Text(card.currency.rawValue)
                }
                .font(.title3.bold())
                .foregroundColor(.accentColor)
            }
            .padding()
        }
    }
}

struct BankAccountView_Previews: PreviewProvider {
    static var previews: some View {
        BankAccountView(card: Card.defaultCard)
    }
}
