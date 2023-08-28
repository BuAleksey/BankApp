//
//  BankTransferView.swift
//  BankApp
//
//  Created by Buba on 27.07.2023.
//

import SwiftUI

struct BankTransferView: View {
    @Binding var user: User
    @Binding var showView: Bool
    
    @State private var selectionCard = 0
    @State private var amount = ""
    @State private var bikCodeDestinationBank = ""
    @State private var recipientsAccount = ""
    
    @State private var showAlertAboutBalance = false
    @State private var showAlertAboutDestinationBankInfo = false
    @State private var transferIsComplete = false
    @State private var blur = false
    
    private let cardManager = CardManager.shared
    private let transaction = Transactions.shared
    private let checkingDetails = CheckingDetails.shared
    
    var body: some View {
        ZStack {
            Color(.gray)
                .opacity(0.05)
                .ignoresSafeArea()
            VStack {
                TabView(selection: $selectionCard) {
                    ForEach(user.cards, id: \.number) { card in
                        CardView(card: card)
                            .tag(card.id)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 240)
                .onAppear {
                    selectionCard = user.cards.first?.id ?? 0
                }
                
                TextField("BIK code of destination bank", text: $bikCodeDestinationBank)
                    .textFieldStyle(GradientTextField())
                    .foregroundColor(
                        bikCodeDestinationBank.count < 9 ? .red : .accentColor
                    )
                    .onChange(of: bikCodeDestinationBank) { _ in
                        bikCodeDestinationBank = String(bikCodeDestinationBank.prefix(9))
                    }
                
                TextField("Recipient's account", text: $recipientsAccount)
                    .textFieldStyle(GradientTextField())
                    .foregroundColor(
                        recipientsAccount.count < 20 ? .red : .accentColor
                    )
                    .onChange(of: recipientsAccount) { _ in
                        recipientsAccount = String(recipientsAccount.prefix(20))
                    }
                
                TextField("Amount", text: $amount)
                    .textFieldStyle(GradientTextField())
                    .padding(.bottom, 30)
                
                CustomButton(action: transfer, title: "Transfer")
                    .alert(
                        "The amount entered is incorrect",
                        isPresented: $showAlertAboutBalance,
                        actions: {}
                    )
                    .alert("The destination bank info is specified incorrectly",
                           isPresented: $showAlertAboutDestinationBankInfo,
                           actions: {}
                    )
                
                Button(action: { showView.toggle() }) {
                    Text("Cancel")
                        .foregroundColor(Color.accentColor)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                }
                .frame(width: 300, height: 50)
                .cornerRadius(10)
                
                Spacer()
            }
            .zIndex(0)
            .keyboardType(.decimalPad)
            .padding()
            
            if blur {
                VisualBlurEffect(uiVisualEffect: UIBlurEffect(
                    style: .systemUltraThinMaterial
                ))
                .ignoresSafeArea()
                .zIndex(2)
            }
            
            if transferIsComplete {
                Image(systemName: "checkmark.seal")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
                    .padding(.bottom, 20)
                    .zIndex(3)
            }
        }
    }
    
    private func transfer() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
        
        guard let foundCard = checkingDetails.cardSearch(
            user: user,
            id: selectionCard
        ) else { return }
        
        if !checkingDetails.checkingDestinationBankInfo(
            bikCode: bikCodeDestinationBank,
            recipientsAccount: recipientsAccount
        ) {
            showAlertAboutDestinationBankInfo.toggle()
            return
        }
        
        if !checkingDetails.checkingAmount(amount: amount, card: foundCard) {
            showAlertAboutBalance.toggle()
            return
        }
        
        withAnimation { blur.toggle() }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeIn(duration: 0.9)) { transferIsComplete.toggle() }
        }
        
        transaction.transferCardToCard(
            user: &user,
            sendersCard: foundCard,
            amount: Double(amount)!
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            showView.toggle()
        }
    }
}

struct BankTransferView_Previews: PreviewProvider {
    static var previews: some View {
        BankTransferView(
            user: .constant(DataBase.shared.defaultUser),
            showView: .constant(true)
        )
    }
}
