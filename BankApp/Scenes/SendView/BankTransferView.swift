//
//  BankTransferView.swift
//  BankApp
//
//  Created by Buba on 27.07.2023.
//

import SwiftUI

struct BankTransferView: View {
    @Binding var selectedTransfer: String
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea()
            VStack {
                Text("Bank Transfer")
                
                CustomButton(action: { selectedTransfer = "" }, title: "Back")
            }
        }
    }
}

struct BankTransferView_Previews: PreviewProvider {
    static var previews: some View {
        BankTransferView(selectedTransfer: .constant(""))
    }
}