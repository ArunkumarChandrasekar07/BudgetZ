//
//  LoginScreen.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 16/01/23.
//

import SwiftUI

struct LoginScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var emailValue: String = ""
    
    @State var passwordValue: String = ""
    
    @State var isSecureText: Bool = true
    
    @State private var isFieldsDisabled: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: 25) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Log in to BudgetZ")
                        .font(.customAppFont(type: .bold, size: 35))
                    
                    emailFieldView()
                    
                    passwordFieldView()
                    
                    Button {
                        
                    } label: {
                        Text("Forgot Password?")
                            .foregroundColor(.white)
                            .font(.appSemiBoldFont)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Login")
                            .font(.customAppFont(type: .bold, size: 20))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            }
                    }
                    
                    HStack(spacing: 5) {
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(.gray.opacity(0.5))
                            .frame(height: 2)
                        
                        Text("OR")
                            .font(.appRegularFont)
                        
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(.gray.opacity(0.5))
                            .frame(height: 2)
                    }
                    
                    continueWithMediaLogin()
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
                
                VStack(alignment: .center) {
                    Text("BudgetZ uses cookies for analytics personalized content and ads. By using BudgetZ's servies you agree to use of this cookies. Learn more") { value in
                        value.foregroundColor = .gray.opacity(0.8)
                        value.font = Font.customAppFont(type: .regular, size: 16)
                        if let range = value.range(of: "Learn more") {
                            value[range].foregroundColor = .white
                            value[range].font = Font.customAppFont(type: .medium, size: 17)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25)
                    .foregroundColor(.gray.opacity(0.8))
                    
                }
            }
            .padding(.top, 10)
            
            VStack {
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward").renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(8)
                            .tint(.white)
                            .background {
                                Circle()
                                    .foregroundColor(.white.opacity(0.4))
                                    .frame(width: 50, height: 50)
                            }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, 25)
                .padding(.bottom, 15)
                
                Spacer().frame(height: 80)
            }
        }
    }
    
    @ViewBuilder
    func emailFieldView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Email")
                .font(.customAppFont(type: .medium, size: 16))
            
            TextField("hello@example.com", text: $emailValue)
                .frame(height: 50)
                .padding(.horizontal, 15)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disabled(isFieldsDisabled)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.6), lineWidth: 2)
                        .foregroundColor(.clear)
                }
        }
    }
    
    @ViewBuilder
    func passwordFieldView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Password")
                .font(.customAppFont(type: .medium, size: 16))
            
            HStack {
                if isSecureText {
                    SecureField("********", text: $passwordValue)
                        .frame(height: 50)
                        .disabled(isFieldsDisabled)
                }else {
                    TextField("********", text: $passwordValue)
                        .frame(height: 50)
                        .disabled(isFieldsDisabled)
                }
                
                Button {
                    isSecureText.toggle()
                } label: {
                    Image(systemName: isSecureText ? "eye.fill" : "eye.slash.fill").renderingMode(.template)
                        .tint(.white)
                }
            }
            .padding(.horizontal, 15)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.6), lineWidth: 2)
                    .foregroundColor(.clear)
            }
        }
    }
    
    @ViewBuilder
    func continueWithMediaLogin() -> some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    isSecureText.toggle()
                } label: {
                    Image(systemName: "apple.logo").renderingMode(.template)
                        .tint(.white)
                }
                
                Text("Continue with Apple")
                    .frame(maxWidth: .infinity)
                    .font(.customAppFont(type: .bold, size: 18))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .padding(.horizontal, 15)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.6), lineWidth: 2)
                    .foregroundColor(.clear)
            }
            
            HStack {
                Button {
                    isSecureText.toggle()
                } label: {
                    Image("googleIcon")
                }
                
                Text("Continue with Google")
                    .frame(maxWidth: .infinity)
                    .font(.customAppFont(type: .bold, size: 18))
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 15)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.6), lineWidth: 2)
                    .foregroundColor(.clear)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}

extension Text {
    init(_ string: String, configure: ((inout AttributedString) -> Void)) {
        var attributedString = AttributedString(string) /// create an `AttributedString`
        configure(&attributedString) /// configure using the closure
        self.init(attributedString) /// initialize a `Text`
    }
}
