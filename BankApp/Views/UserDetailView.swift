//
//  UserDetailView.swift
//  BankApp
//
//  Created by Buba on 08.06.2023.
//

import SwiftUI

struct UserDetailView: View {
    @Binding var user: User
    @Binding var isShowMainView: Bool
    
    @Environment (\.dismiss) var dissmis
    
    private let colors = [Color("blue"), Color("lightBlue")]
    
    var body: some View {
        VStack {
            Image(user.image)
                .resizable()
                .frame(width: 250, height: 250)
                .padding([.top, .bottom])
            
            Text(user.name)
                .foregroundColor(.accentColor)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.bottom, 30)
            
            VStack(spacing: 8){
                HStack {
                    Image(systemName: "envelope")
                        .fontWeight(.heavy)
                    Text(user.mail)
                    Spacer()
                }
                HStack {
                    Image(systemName: "phone")
                        .fontWeight(.heavy)
                    Text(user.phoneNumber)
                    Spacer()
                }
            }
            
            Spacer()
            
            Button(action: logOutButtonTapped) {
                Text("Log out")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.accentColor)
            .cornerRadius(10)
            .padding(30)
        }
        .padding(.top, 30)
        .padding()
        .frame(maxWidth: .infinity)
        .background(LinearGradient(
            colors: colors,
            startPoint: .top,
            endPoint: .bottom
        ))
    }
    
    private func logOutButtonTapped() {
        isShowMainView = false
        dissmis()
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: .constant(User(name: "Ignat", password: "12345")), isShowMainView: .constant(false))
    }
}
