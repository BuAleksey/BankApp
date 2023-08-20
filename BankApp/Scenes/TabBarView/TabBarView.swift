//
//  TabBarView.swift
//  BankApp
//
//  Created by Buba on 12.06.2023.
//

import SwiftUI

struct TabBarView: View {
    @Binding var user: User
    @Binding var activateRootLink: Bool
    
    @State private var selectedTab: Tab = .house
    @State private var selectedItem: Category? = nil
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        switch selectedTab {
                        case .house:
                            HomeView(user: $user, selectedItem: $selectedItem)
                                .edgesIgnoringSafeArea(.bottom)
                        case .creditcard:
                            SendView(user: $user)
                        case .gearshape:
                            SettingsView(activateRootLink: $activateRootLink)
                        }
                    }
                }
            }
            
            VStack {
                Spacer()
                if selectedItem == nil {
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(
            user: .constant(DataBase.defaultUser),
            activateRootLink: .constant(false)
        )
    }
}
