//
//  SignUpScreen.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 16/01/23.
//

import SwiftUI
import GoogleSignIn

struct SignUpScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var authModel = AuthenticationViewModel()
    
    @State var emailValue: String = ""
    
    @State var passwordValue: String = ""
    
    @State var isSecureText: Bool = true
    
    @State private var toast: FancyToast? = nil
    
    @State private var isFieldsDisabled: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: 25) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Get your Free Account")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.customAppFont(type: .bold, size: 32))
                    
                    continueWithMediaLogin()
                    
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
                    
                    emailFieldView()
                    
                    passwordFieldView()
                    
                    Button {
                        guard isValidEmail(emailValue) else { toast = FancyToast(type: .error, title: "Invalid Email", message: "Please enter a valid Email Id.", duration: 2); return}
                        
                        guard isValidPassword(passwordValue) else { toast = FancyToast(type: .error, title: "Invalid Password", message: "Your password must be greater than 6 characters.", duration: 2); return}
                        
                        isFieldsDisabled.toggle()
                        
                        toast = FancyToast(type: .loader, title: "Signing up. Please wait.", message: "")
                        
                        getSignupUser(with: emailValue, password: passwordValue)
                    } label: {
                        Text("Signup")
                            .font(.customAppFont(type: .bold, size: 20))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                            }
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 15)
            }
            .padding(.top, 10)
            .toastView(toast: $toast)
            
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
                    isFieldsDisabled.toggle()
                    toast = FancyToast(type: .loader, title: "Loading.. Please wait..")
                    authModel.startSignInWithAppleFlow()
                } label: {
                    HStack {
                        Image(systemName: "apple.logo").renderingMode(.template)
                            .tint(.white)
                        
                        Text("Continue with Apple")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.customAppFont(type: .bold, size: 18))
                    }
                }
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
                    isFieldsDisabled.toggle()
                    toast = FancyToast(type: .loader, title: "Loading.. Please wait..")
                    authModel.googleSignIn { user, error in
                        toast = nil
                        isFieldsDisabled.toggle()
                        if let user = user {
                            toast = FancyToast(type: .success, title: "Google Login Success", message: "\(user.email ?? "") is created successfully", duration: 5)
                        }else {
                            toast = FancyToast(type: .error, title: "Google Login Failed", message: error, duration: 5)
                        }
                    }
                } label: {
                    HStack {
                        Image("googleIcon")
                        
                        Text("Continue with Google")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .font(.customAppFont(type: .bold, size: 18))
                    }
                }
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
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let minPasswordLength = 6
        return password.count >= minPasswordLength
    }
    
    private func getSignupUser(with email: String, password: String) {
        authModel.signUpUser(with: email, password: password) { user, error in
            toast = nil
            isFieldsDisabled.toggle()
            if error != "" {
                toast = FancyToast(type: .error, title: "Signup Failed", message: error, duration: 2)
            }else {
                toast = FancyToast(type: .success, title: "Signup Success", message: "Account created successfully", duration: 2)
            }
        }
    }
    
    
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
