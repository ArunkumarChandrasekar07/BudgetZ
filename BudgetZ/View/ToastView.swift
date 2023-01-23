//
//  ToastView.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 17/01/23.
//

import SwiftUI
import Lottie

struct ToastView: View {
    
    var type: ToastStyle
    var title: String
    var message: String?
    var onCancelTapped: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                if type == .loader {
                    LottieView(lottieFile: "Lotti_Loader")
                        .frame(width: 50, height: 50)
                }else {
                    Image(systemName: type.iconFileName)
                        .foregroundColor(type.themeColor)
                }
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.customAppFont(type: .bold, size: 18))
                        .foregroundColor(.black)
                    if message != nil {
                        Text(message ?? "")
                            .font(.customAppFont(type: .medium, size: 16))
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                }
                Spacer(minLength: 10)
                
                if onCancelTapped != nil {
                    Button {
                        onCancelTapped!()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black)
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(type == .loader ? Color.white : type.themeColor)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(type: .loader, title: "Loading. Please wait.")
    }
}

extension View {
    func toastView(toast: Binding<FancyToast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
