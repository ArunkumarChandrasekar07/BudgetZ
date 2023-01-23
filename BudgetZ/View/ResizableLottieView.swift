//
//  ResizableLottieView.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 19/01/23.
//

import SwiftUI

struct ResizableLottieView: UIViewRepresentable {
    
    @Binding var onboardingItem: OnBoardingItem
    
    func makeUIView(context: Context) -> UIView {
        let view: UIView = UIView()
        view.backgroundColor = .clear
        setupLottieView(view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    private func setupLottieView(_ to: UIView) {
        let lottieView = onboardingItem.lottieView
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor),
        ]
        
        to.addSubview(lottieView)
        to.addConstraints(constraints)
    }
}
