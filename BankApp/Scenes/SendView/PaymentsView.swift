//
//  PaymentsView.swift
//  BankApp
//
//  Created by Buba on 21.06.2023.
//

import SwiftUI

struct PaymentsView: View {
    let color: String
    let text: String
    var image: String? = nil
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 150, height: 150)
                    .foregroundColor(Color(color))
                
                VStack(alignment: .leading) {
                    ZStack {
                        Circle()
                            .foregroundColor(.white.opacity(0.5))
                            .frame(width: 50, height: 50)
                        
                        if let image = image {
                            Image(systemName: image)
                                .font(.title2)
                        }
                    }
                    .padding(.bottom)
                    
                    Text(text)
                        .font(.headline)
                }
                .padding()
            }
        }
    }
}

struct PaymentsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsView(color: "blue", text: "Peyments", image: "creditcard", action: {})
    }
}
