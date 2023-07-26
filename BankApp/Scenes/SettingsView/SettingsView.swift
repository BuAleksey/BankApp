//
//  SettingsView.swift
//  BankApp
//
//  Created by Buba on 12.06.2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var activateRootLink: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                CustomButton(action: { activateRootLink.toggle() }, title: "Log out")
            }
        }
        .padding()
        .background(.gray.opacity(0.05))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(activateRootLink: .constant(true))
    }
}
