//
//  InitialScreen.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 16/01/23.
//

import SwiftUI
import SwiftUINavigation

enum Destination {
    case initial
    case login
    case signup
}

struct InitialScreen: View {
    
    @State var destination: Destination?
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Welcome to")
                        .font(.customAppFont(type: .medium, size: 40))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("BudgetZ")
                        .font(.customAppFont(type: .extrabold, size: 50))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 15)
                
                Text("A best way to handle all your budget and accounts details in one place.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                
                Spacer()
                
                Spacer()
                
                Spacer()
            }
            
            VStack {
                Button {
                    self.destination = .login
                } label: {
                    Text("Sign In")
                        .font(.customAppFont(type: .bold, size: 20))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.black)
                        .padding(20)
                        .background {
                            Capsule(style: .continuous)
                                .foregroundColor(.white)
                        }
                }
                .navigationDestination(unwrapping: $destination, case: /Destination.login) { _ in
                    LoginScreen()
                        .navigationBarBackButtonHidden()
                        .navigationBarTitleDisplayMode(.inline)
                }
                
                Button {
                    self.destination = .signup
                } label: {
                    Text("Sign Up")
                        .font(.customAppFont(type: .bold, size: 20))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding(20)
                        .background {
                            Capsule(style: .continuous)
                                .stroke(Color.white, lineWidth: 2)
                        }
                }
                .navigationDestination(unwrapping: $destination, case: /Destination.signup) { _ in
                    SignUpScreen()
                        .navigationBarBackButtonHidden()
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct InitialScreen_Previews: PreviewProvider {
    static var previews: some View {
        InitialScreen()
    }
}
