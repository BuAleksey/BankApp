//
//  CategoryDetailView.swift
//  BankApp
//
//  Created by Buba on 01.06.2023.
//

import SwiftUI

struct CategoryDetailView: View {
    let item: Category
    
    var body: some View {
        return Color.clear.overlay {
            VStack {
                Text(item.title)
                    .font(.title)
                    .padding()
                
                Spacer()
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.gray.opacity(0.1))
                        .frame(width: 260)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(item.color))
                        .frame(width: CGFloat(item.percent) * 2.6)
                }
                .frame(height: 30)
                .padding()
            }
            .padding()
            .frame(width: 300, height: 300)
            .background(.white)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .frame(width: 300, height: 300)
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(item: Category(title: "Transport", color: "blue", percent: 60))
    }
}
