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
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea(.all)
            VStack {
                Text("Settings")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                CustomButton(action: { activateRootLink.toggle() }, title: "Log out")
                    .padding(.bottom, 30)
            }
            .toolbar(.hidden)
            .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(activateRootLink: .constant(true))
    }
}
