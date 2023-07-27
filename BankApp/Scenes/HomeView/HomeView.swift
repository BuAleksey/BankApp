//
//  HomeView.swift
//  BankApp
//
//  Created by Buba on 31.05.2023.
//

import SwiftUI

struct HomeView: View {
    @Binding var user: User
    @Binding var selectedItem: Category?
    
    @State private var isShowingUserDetail = false
    @State private var isShowingNewCardView = false
    
    @State private var blur = false
    @State private var coloumns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        VStack {
            if selectedItem == nil {
                header()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(user.cards) { card in
                            GeometryReader { geo in
                                CardView(card: card)
                                    .rotation3DEffect(
                                        .degrees(-Double(geo.frame(in: .global).minX/15)),
                                        axis: (x: 0, y: 1, z: 0)
                                    )
                            }
                            .frame(width: 250, height: 250)
                        }
                    }
                    .padding(.trailing)
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
                    VisualBlurEffect(uiVisualEffect: UIBlurEffect(
                        style: .systemUltraThinMaterial
                    ))
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
            .frame(
                maxWidth: .infinity,
                maxHeight: selectedItem == nil ? 250 : .infinity
            )
            
            if selectedItem == nil {
                
                NavigationLink {
                    NewCardView(user: $user)
                } label: {
                    Text("Open a new card")
                        .foregroundColor(.white)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .frame(width: 300, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .background(.gray.opacity(0.05))
        .toolbar(.hidden)
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
        }
        .onTapGesture {
            isShowingUserDetail = true
        }
        .sheet(isPresented: $isShowingUserDetail) {
            isShowingUserDetail = false
        } content: {
            UserDetailView(user: $user)
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
        HomeView(
            user: .constant(User(
                name: "Ignat",
                password: "12345",
                cards: [Card(
                    currency: .rub,
                    paymentSystem: .mir
                )]
            )),
            selectedItem: .constant(nil)
        )
    }
}
