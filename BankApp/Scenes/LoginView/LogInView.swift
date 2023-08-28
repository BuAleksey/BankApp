//
//  LogInView.swift
//  BankApp
//
//  Created by Buba on 08.06.2023.
//

import SwiftUI

struct LogInView: View {
    @State private var user = DataBase.shared.defaultUser
    
    @State private var name = ""
    @State private var password = ""
    
    @State private var checkIsDone = false
    @State private var isShowingHint = false
    @State private var activateRootLink = false
    
    private let userManager = UserManager.shared
    private let chekingDetails = CheckingDetails.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                LogoView()
                Spacer()
                
                if isShowingHint {
                    HintView()
                }
                
                TextField("Inter your name", text: $name)
                    .textFieldStyle(GradientTextField(image: "person"))
                    .onChange(of: name) { _ in
                        checkIsDone = chekingDetails.checkingUsersLoginParametrs(
                            login: name,
                            password: password
                        )
                        if checkIsDone {
                            user = userManager.createUser(
                                name: name,
                                password: password
                            )
                        }
                    }
                    .padding(.bottom, 8)
                
                SecureTextField(password: $password)
                    .onChange(of: password) { _ in
                        checkIsDone = chekingDetails.checkingUsersLoginParametrs(
                            login: name,
                            password: password
                        )
                        if checkIsDone {
                            user = userManager.createUser(
                                name: name,
                                password: password
                            )
                        }
                    }
                    .padding(.bottom, 20)
                
                CustomButton(action: { activateRootLink.toggle() }, title: "Input")
                    .navigationDestination(isPresented: $activateRootLink) {
                        TabBarView(user: $user, activateRootLink: $activateRootLink)
                    }
                    .disabled(!checkIsDone)
                    .onAppear {
                        password = ""
                        isShowingHint = false
                    }
                    .onTapGesture {
                        withAnimation() {
                            isShowingHint = true
                        }
                    }
                Spacer()
            }
            .frame(width: 300)
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
    }
}

struct HintView: View {
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
            Text("The name and password fields should not be empty")
                .font(.system(.caption2))
        }
    }
}
