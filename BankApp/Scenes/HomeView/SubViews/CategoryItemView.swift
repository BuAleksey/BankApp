//
//  CategoryItemView.swift
//  BankApp
//
//  Created by Buba on 01.06.2023.
//

import SwiftUI

struct CategoryItemView: View {
    let item: Category
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                Text(item.title)
                    .foregroundColor(.accentColor)
                
                Spacer()
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.gray.opacity(0.1))
                        .frame(width: 130)
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color(item.color))
                        .frame(width: CGFloat(item.percent) * 1.3)
                }
                .frame(height: 15)
            }
            .padding()
        }
        .frame(width: 160, height: 100)
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(item: Category.categorys.first!)
    }
}
