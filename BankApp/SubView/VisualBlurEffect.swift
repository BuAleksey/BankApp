//
//  VisualBlurEffect.swift
//  BankApp
//
//  Created by Buba on 01.06.2023.
//

import SwiftUI

struct VisualBlurEffect: UIViewRepresentable {
    var uiVisualEffect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.effect = uiVisualEffect
    }
}
