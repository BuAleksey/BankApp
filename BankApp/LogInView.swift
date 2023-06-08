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
            Label {
                Text("BankName")
                    .foregroundColor(.accentColor)
                    .font(.system(.title, design: .rounded))
                    .offset(x: -10, y: 20)
            } icon: {
                Image("bank")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .opacity(0.6)
            }
            .padding(.bottom, 50)
            
            
            TextField("Inter your name...", text: $userName)
                .textFieldStyle(GradientTextField(image: "person"))
                .padding(.bottom, 8)
            
            TextField("Inter your password...", text: $userPassword)
                .textFieldStyle(GradientTextField(image: "key"))
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
            }
        }
        .fullScreenCover(isPresented: $isShowMainView) {
            HomeView(user: $user)
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

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(user: User(name: "Ignat", password: "12345"))
    }
}
