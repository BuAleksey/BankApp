//
//  CardToCardView.swift
//  BankApp
//
//  Created by Buba on 27.07.2023.
//

import SwiftUI

struct CardToCardView: View {
    @Binding var user: User
    @Binding var selectedTransfer: String
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea()
            VStack {
                Text("Card to card")
                
                CustomButton(action: { selectedTransfer = "" }, title: "Back")
            }
        }
    }
}

struct CardToCardView_Previews: PreviewProvider {
    static var previews: some View {
        CardToCardView(user: .constant(User.defaultUser), selectedTransfer: .constant(""))
    }
}
