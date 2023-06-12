//
//  HomeView.swift
//  BankApp
//
//  Created by Buba on 31.05.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var blur = false
    @State private var isShowingUserDetail = false
    @State private var coloumns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    @Binding var user: User
    @Binding var selectedItem: Category?
    
    var body: some View {
        VStack {
            if selectedItem == nil {
                
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
            }
            
            ZStack {
                LazyVGrid(columns: coloumns, spacing: 10) {
                    ForEach(Category.categorys) { item in
                        CategoryItemView(item: item)
                            .onLongPressGesture {
                                tapToCategory(item)
                            }
                    }
                }
                .zIndex(1)
                
                if blur {
                    VisualBlurEffect(uiVisualEffect: UIBlurEffect(style: .systemUltraThinMaterial))
                        .ignoresSafeArea(.all)
                        .onTapGesture {
                            tapToBack()
                        }
                        .zIndex(2)
                }
                
                if selectedItem != nil {
                    CategoryDetailView(item: selectedItem!)
                        .zIndex(3)
                }
            }
            .offset(y: selectedItem == nil ? -50 : 0)
            .frame(maxWidth: .infinity, maxHeight: selectedItem == nil ? 250 : .infinity)
            
            if selectedItem == nil {
                Button {
                    print("New card button tapped...")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                        Text("Open a new card")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                }
                .offset(y: -50)
                .frame(maxWidth: .infinity)
                .frame(height: 43)
                .padding(32)
            }
            Spacer()
        }
        .background(.gray.opacity(0.05))
    }
    
    @ViewBuilder private func header() -> some View {
        HStack {
            Text("Welcome back,\n \(user.name)!")
                .font(.system(size: 22, weight: .bold, design: .default))
                .foregroundColor(.accentColor)
            Spacer()
            
            ZStack {
                Circle()
                    .foregroundColor(Color("blue"))
                    .frame(width: 80, height: 80)
                Image("human")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .onTapGesture {
                isShowingUserDetail = true
            }
            .sheet(isPresented: $isShowingUserDetail) {
                isShowingUserDetail = false
            } content: {
                UserDetailView(user: $user)
            }
        }
        .padding([.trailing, .leading])
    }
    
    private func tapToBack() {
        withAnimation(.default) { blur = false }
        
        DispatchQueue.main.async {
            withAnimation(.default) { selectedItem = nil }
        }
    }
    
    private func tapToCategory(_ item: Category) {
        withAnimation(.default) { selectedItem = item }
        
        DispatchQueue.main.async {
            withAnimation(.default) { blur = true }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(user: .constant(User(name: "Ignat", password: "12345")), selectedItem: .constant(nil))
    }
}
