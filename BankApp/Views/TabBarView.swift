//
//  TabBarView.swift
//  BankApp
//
//  Created by Buba on 12.06.2023.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Tab = .house
    @State private var selectedItem: Category? = nil
    
    @Binding var user: User
    @Binding var isShowMainView: Bool
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        switch selectedTab {
                        case .house:
                            HomeView(user: $user, selectedItem: $selectedItem, isShowMainView: $isShowMainView)
                        case .creditcard:
                            SendView()
                        case .gearshape:
                            SettingsView()
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
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
        TabBarView(user: .constant(User(name: "", password: "")), isShowMainView: .constant(true))
    }
}
