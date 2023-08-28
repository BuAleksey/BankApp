//
//  CardInfoView.swift
//  BankApp
//
//  Created by Buba on 28.08.2023.
//

import SwiftUI

struct CardInfoView: View {
    let text: String
    let card: Card
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("lightBlue"))
            VStack(alignment: .leading) {
                Text(text)
                    .foregroundColor(.gray)
                HStack {
                    Text("• \(card.number)")
                    Text(card.currency.symbol)
                }
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
    }
}

struct CardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CardInfoView(text: "From", card: DataBase.shared.defaultCard)
    }
}
