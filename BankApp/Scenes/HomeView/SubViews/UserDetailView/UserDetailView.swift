//
//  UserDetailView.swift
//  BankApp
//
//  Created by Buba on 08.06.2023.
//

import SwiftUI

struct UserDetailView: View {
    @Binding var user: User
    @Environment (\.dismiss) var dissmis
    
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
                .padding(.bottom, 20)
                
                HStack {
                    Image(systemName: "creditcard.circle")
                        .fontWeight(.heavy)
                    HStack {
                        Text("Toral balance: ")
                        Text(BalanceManager.shared.calculateTotalBalance(user: user).formatted())
                        Text("₽")
                    }
                    Spacer()
                }
            }
            Spacer()
            
        }
        .padding(.top, 30)
        .padding()
        .frame(maxWidth: .infinity)
        .background(LinearGradient(
            colors: [Color("blue"), Color("lightBlue")],
            startPoint: .top,
            endPoint: .bottom
        ))
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(
            user: .constant(User(
                name: "Ignat",
                password: "12345",
                cards: [Card(
                    currency: .rub,
                    paymentSystem: .mir
                )]
            )))
    }
}
