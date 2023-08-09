//
//  LogInView.swift
//  BankApp
//
//  Created by Buba on 08.06.2023.
//

import SwiftUI

struct LogInView: View {
    @State private var user = User.defaultUser
    
    @State private var userName = ""
    @State private var userPassword = ""
    
    @State private var checkIsDone = false
    @State private var showAlert = false
    @State private var activateRootLink = false
    
    var body: some View {
        NavigationView {
            VStack {
                LogoView()
                
                TextField("Inter your name...", text: $userName)
                    .textFieldStyle(GradientTextField(image: "person"))
                    .padding(.bottom, 8)
                
                SecureTextField(password: $userPassword)
                    .padding(.bottom, 20)
                
                NavigationLink(isActive: $activateRootLink) {
                    TabBarView(user: $user, activateRootLink: $activateRootLink)
                } label: {
                    Text("Input")
                        .foregroundColor(.white)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .frame(width: 300, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .onAppear {
                    userPassword = ""
                }
                .disabled(!makeBtnEnabled())
                .simultaneousGesture(TapGesture().onEnded({ _ in
                    checkLogoParametrs(name: userName, password: userPassword)
                }))
                .alert("Enter the correct data", isPresented: $showAlert, actions: {} )
            }
            .frame(width: 300)
            .offset(y: -100)
        }
    }
    
    private func checkLogoParametrs(name: String, password: String) {
        if let _ = Double(name), let _ = Double(password) {
            userName = ""
            userPassword = ""
            showAlert = true
            checkIsDone = false
        } else if name != "", password != "" {
            user = User(name: name, password: password, cards: Card.cards)
            checkIsDone = true
        } else {
            userName = ""
            userPassword = ""
            showAlert = true
            checkIsDone = false
        }
    }
    
    private func makeBtnEnabled() -> Bool {
        if userName != "", userPassword != "" {
            return true
        } else {
            return false
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}

struct LogoView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("bank")
                .resizable()
                .frame(width: 150, height: 150)
                .opacity(0.2)
            
            Text("BankName")
                .foregroundColor(.accentColor)
                .font(.system(.body, design: .rounded))
                .offset(y:-10)
        }
        .padding(.bottom, 50)
    }
}
