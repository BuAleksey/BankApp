//
//  HomeView.swift
//  BankApp
//
//  Created by Buba on 31.05.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            header()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(Card.colors) { colors in
                        GeometryReader { geo in
                            CardView(colors: colors.colors)
                                .rotation3DEffect(
                                    .degrees(-Double(geo.frame(in: .global).minX/15)),
                                    axis: (x: 0, y: 1, z: 0)
                                )
                        }
                        .frame(width: 250, height: 250)
                    }
                }
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    
    private func header() -> some View {
        HStack {
            Text("Welcome back,\n Alex!")
                .font(.system(size: 22, weight: .bold, design: .default))
                .foregroundColor(Color("textColor"))
            
            Spacer()
            
            ZStack {
                Circle()
                    .foregroundColor(Color("blueColor"))
                    .frame(width: 80, height: 80)
                Image("human")
            }
        }
        .padding([.trailing, .leading])
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
