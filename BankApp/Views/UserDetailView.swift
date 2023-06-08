//
//  UserDetailView.swift
//  BankApp
//
//  Created by Buba on 08.06.2023.
//

import SwiftUI

struct UserDetailView: View {
    @Binding var user: User
    let colors = [Color("blue"), Color("lightBlue")]
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 350, height: 350)
                    .foregroundColor(Color("purple").opacity(0.4))
                Image(user.image)
                    .resizable()
                    .frame(width: 250, height: 250)
            }
            .padding([.top, .bottom])
            
            Text(user.name)
                .foregroundColor(.accentColor)
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(LinearGradient(
            colors: colors,
            startPoint: .top,
            endPoint: .bottom
        ))
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: .constant(User(name: "Ignat", password: "12345")))
    }
}
