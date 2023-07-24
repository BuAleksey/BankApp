//
//  SettingsView.swift
//  BankApp
//
//  Created by Buba on 12.06.2023.
//

import SwiftUI

enum Language: String, CaseIterable {
    case English
    case Russian
}

struct SettingsView: View {
    @State var text = ""
    
    var body: some View {
        ZStack {
            VStack {
                Text("Settings")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.bold)
                
                HStack {
                    Text("Language")
                    Spacer()
                    Picker("Language", selection: $text) {
                        ForEach(Language.allCases, id: \.rawValue) { language in
                            Text(language.rawValue)
                        }
                    }
                    .font(.system(.title3, design: .rounded))
                }
                .font(.system(.title3, design: .rounded))
                
                Spacer()
            }
        }
        .padding()
        .background(.gray.opacity(0.05))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
