//
//  CustomTextFields.swift
//  BankApp
//
//  Created by Buba on 23.06.2023.
//

import SwiftUI

struct GradientTextField: TextFieldStyle {
    var image: String? = nil
    
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
                if let image = image {
                    Image(systemName: image)
                        .foregroundColor(.accentColor)
                }
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
