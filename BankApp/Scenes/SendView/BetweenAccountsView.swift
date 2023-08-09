//
//  BetweenAccountsView.swift
//  BankApp
//
//  Created by Buba on 27.07.2023.
//

import SwiftUI

struct BetweenAccountsView: View {
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea()
            VStack {
                Text("Between Accounts")
            }
        }
    }
}

struct BetweenAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        BetweenAccountsView()
    }
}
