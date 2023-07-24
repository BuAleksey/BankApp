//
//  LogInView.swift
//  BankApp
//
//  Created by Buba on 08.06.2023.
//

import SwiftUI

struct LogInView: View {
    @State private var userName = ""
    @State private var userPassword = ""
    @State private var user = User(name: "123", password: "123")
    
    @State private var isShowMainView = false
    @State private var isShowAlert = false
    
    var body: some View {
        VStack {
            LogoView()
            
            TextField("Inter your name...", text: $userName)
                .textFieldStyle(GradientTextField(image: "person"))
                .padding(.bottom, 8)
            
            SecureTextField(password: $userPassword)
                .padding(.bottom, 20)
            
            CustomButton(action: inputButtonTapped, title: "Input")
                .fullScreenCover(isPresented: $isShowMainView) {
                    TabBarView(user: $user, isShowMainView: $isShowMainView)
                }
                .alert("Wrong format", isPresented: $isShowAlert, actions: {}) {
                    Text("Enter your name and password")
                }
        }
        .frame(width: 300)
        .offset(y: -100)
    }
    
    private func inputButtonTapped() {
        if checkLogoParametrs(name: userName, password: userPassword) {
            isShowMainView = true
            user = User(name: userName, password: userPassword)
        } else {
            userName = ""
            userPassword = ""
            isShowAlert = true
        }
    }
    
    private func checkLogoParametrs(name: String, password: String) -> Bool {
        if let _ = Double(name), let _ = Double(password) {
            return false
        } else if name != "", password != "" {
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
