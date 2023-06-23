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
    @State private var isShowMainView = false
    @State private var user = User(name: "123", password: "123")
    
    var body: some View {
        VStack {
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
            
            TextField("Inter your name...", text: $userName)
                .textFieldStyle(GradientTextField(image: "person"))
                .padding(.bottom, 8)
            
            SecureTextField(password: $userPassword)
                .padding(.bottom, 20)
            
            Button(action: inputButtonTapped) {
                Text("Input")
                    .foregroundColor(.white)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
            }
            .frame(width: 300, height: 50)
            .background(Color.accentColor)
            .cornerRadius(10)
            .fullScreenCover(isPresented: $isShowMainView) {
                TabBarView(user: $user, isShowMainView: $isShowMainView)
            }
        }
        .frame(width: 300)
        .offset(y: -100)
    }
    
    private func inputButtonTapped() {
        isShowMainView = true
        user = User(name: userName, password: userPassword)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
