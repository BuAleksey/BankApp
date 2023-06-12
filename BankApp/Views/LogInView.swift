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
    @State var user = User(name: "123", password: "123")
    
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
            
            Button {
                isShowMainView = true
                user = User(name: userName, password: userPassword)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.accentColor)
                        .frame(height: 50)
                    
                    Text("Input")
                        .foregroundColor(.white)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                }
            }
            .fullScreenCover(isPresented: $isShowMainView) {
                TabBarView(user: $user)
            }
        }
        .frame(width: 300)
        .offset(y: -100)
    }
}

struct GradientTextField: TextFieldStyle {
    let image: String
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(LinearGradient(
                    colors: [Color("blue"), Color("lightBlue")],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .frame(height: 40)
            
            HStack {
                Image(systemName: image)
                    .foregroundColor(.accentColor)
                configuration
            }
            .padding([.leading, .trailing], 8)
        }
    }
}

struct SecureTextField: View {
    @State private var isSecure = true
    @Binding var password: String
    
    var body: some View {
        HStack {
            if isSecure {
                SecureField("Enter your password...", text: $password)
                    .textFieldStyle(GradientTextField(image: "key"))
            } else {
                TextField("Enter your password...", text: $password)
                    .textFieldStyle(GradientTextField(image: "key"))
            }
        }
        .foregroundColor(.accentColor)
        .overlay(alignment: .trailing) {
            Image(systemName: isSecure ? "eye.slash" : "eye")
                .foregroundColor(.accentColor)
                .padding(.trailing, 8)
                .onTapGesture {
                    isSecure.toggle()
                }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(user: User(name: "Ignat", password: "12345"))
    }
}
