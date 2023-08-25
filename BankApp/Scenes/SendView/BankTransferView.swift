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
    
    @State private var showAlertAboutCardChoosing = false
    @State private var showAlertAboutBalance = false
    @State private var showAlertAboutDestinationBankInfo = false
    @State private var transferIsComplete = false
    
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
                    .onChange(of: bikCodeDestinationBank) { _ in
                        bikCodeDestinationBank = String(bikCodeDestinationBank.prefix(9))
                    }
                
                TextField("Recipient's account", text: $recipientsAccount)
                    .textFieldStyle(GradientTextField())
                    .onChange(of: recipientsAccount) { _ in
                        recipientsAccount = String(recipientsAccount.prefix(20))
                    }
                
                TextField("Amount", text: $amount)
                    .textFieldStyle(GradientTextField())
                    .padding(.bottom, 30)
                
                Image(systemName: transferIsComplete ? "checkmark.seal" : "")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.green)
                    .padding(.bottom, 30)
                
                CustomButton(action: transfer, title: "Transfer")
                    .alert(
                        "Please choose the card",
                        isPresented: $showAlertAboutCardChoosing,
                        actions: {}
                    )
                    .alert(
                        "Еhe amount entered is incorrect",
                        isPresented: $showAlertAboutBalance,
                        actions: {}
                    )
                    .alert("Еhe destination bank info is specified incorrectly",
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
            .padding()
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
        ) else {
            showAlertAboutCardChoosing.toggle()
            return
        }
        
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
        
        withAnimation(.easeIn(duration: 0.7)) { transferIsComplete.toggle() }
        
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
        BankTransferView(user: .constant(DataBase.defaultUser), showView: .constant(true))
    }
}
