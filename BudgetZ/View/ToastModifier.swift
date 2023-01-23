//
//  ToastModifier.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 18/01/23.
//

import Foundation
import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var toast: FancyToast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: -30)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                if toast?.duration != nil {
                    showToast()
                }
            }
    }
    
    
    @ViewBuilder func mainToastView() -> some View {
        if toast != nil {
            VStack {
                Spacer()
                ToastView(type: toast!.type, title: toast!.title, message: toast!.message)
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toast.duration! > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration!, execute: task)
        }
    }
    
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}
