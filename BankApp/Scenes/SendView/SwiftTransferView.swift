//
//  SwiftTransferView.swift
//  BankApp
//
//  Created by Buba on 27.07.2023.
//

import SwiftUI

struct SwiftTransferView: View {
    @Binding var selectedTransfer: String
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea()
            VStack {
                Text("SWIFT transfer")
                
                CustomButton(action: { selectedTransfer = "" }, title: "Back")
            }
        }
    }
}

struct SwiftTransferView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftTransferView(selectedTransfer: .constant(""))
    }
}
