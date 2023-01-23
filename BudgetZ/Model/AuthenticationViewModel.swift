//
//  AuthenticationViewModel.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 17/01/23.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

enum AuthenticationErrors: String {
    case invalidEmail           =   "Email Id is invalid. Please use a valid Email."
    case emailAlreadyInUse      =   "Email is already in use. Please use an alternate email."
    case notDetermined          =   "Your account is disabled. Please contact admin for further information."
    case defaultMessage         =   "Something went wrong. Please try again after some time."
    case weakPassword           =   "The password must be 6 characters long or more"
}

class AuthenticationViewModel: ObservableObject {
        
    typealias authCompletionClosure = ((_ user: User?, _ error: String) -> Void)
    
    private var authCompletionHandler: authCompletionClosure?
    
    func signUpUser(with email: String, password: String, completionHandler: @escaping authCompletionClosure) {
        self.authCompletionHandler = completionHandler
        
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if let error = error {
                if let errCode = AuthErrorCode.Code(rawValue: error._code) {
                    self.alertUser(with: errCode)
                }else {
                    authCompletionHandler?(nil, AuthenticationErrors.defaultMessage.rawValue)
                }
            }else {
                if let authResult = authResult {
                    authCompletionHandler?(authResult.user, "")
                }else {
                    authCompletionHandler?(nil, "")
                }
            }
        }
    }
    
    func googleSignIn(completionHandler: @escaping authCompletionClosure) {
        
        authCompletionHandler = completionHandler
        
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            let configuration = GIDConfiguration(clientID: clientID)
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            GIDSignIn.sharedInstance.configuration = configuration
            
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] signInResult, error in
                self?.authenticateUser(for: signInResult?.user, with: error)
            }
        }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        if let error = error {
            authCompletionHandler?(nil, error.localizedDescription)
            return
        }
        
        guard let idToken = user?.idToken, let accessToken = user?.accessToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { [unowned self] authResult, error in
            if let error = error {
                if let errCode = AuthErrorCode.Code(rawValue: error._code) {
                    self.alertUser(with: errCode)
                }else {
                    authCompletionHandler?(nil, AuthenticationErrors.defaultMessage.rawValue)
                }
            }else {
                if let result = authResult {
                    authCompletionHandler?(result.user, "")
                }else {
                    authCompletionHandler?(nil, AuthenticationErrors.defaultMessage.rawValue)
                }
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func alertUser(with code: AuthErrorCode.Code) {
        switch code {
        case .invalidCustomToken:
            authCompletionHandler?(nil, "")
        case .customTokenMismatch:
            authCompletionHandler?(nil, "")
        case .invalidCredential:
            authCompletionHandler?(nil, "")
        case .userDisabled:
            authCompletionHandler?(nil, "")
        case .operationNotAllowed:
            authCompletionHandler?(nil, AuthenticationErrors.notDetermined.rawValue)
        case .emailAlreadyInUse:
            authCompletionHandler?(nil, AuthenticationErrors.emailAlreadyInUse.rawValue)
        case .invalidEmail:
            authCompletionHandler?(nil, AuthenticationErrors.invalidEmail.rawValue)
        case .wrongPassword:
            authCompletionHandler?(nil, "")
        case .tooManyRequests:
            authCompletionHandler?(nil, "")
        case .userNotFound:
            authCompletionHandler?(nil, "")
        case .accountExistsWithDifferentCredential:
            authCompletionHandler?(nil, "")
        case .requiresRecentLogin:
            authCompletionHandler?(nil, "")
        case .providerAlreadyLinked:
            authCompletionHandler?(nil, "")
        case .noSuchProvider:
            authCompletionHandler?(nil, "")
        case .invalidUserToken:
            authCompletionHandler?(nil, "")
        case .networkError:
            authCompletionHandler?(nil, "")
        case .userTokenExpired:
            authCompletionHandler?(nil, "")
        case .invalidAPIKey:
            authCompletionHandler?(nil, "")
        case .userMismatch:
            authCompletionHandler?(nil, "")
        case .credentialAlreadyInUse:
            authCompletionHandler?(nil, "")
        case .weakPassword:
            authCompletionHandler?(nil, AuthenticationErrors.weakPassword.rawValue)
        case .appNotAuthorized:
            authCompletionHandler?(nil, "")
        case .expiredActionCode:
            authCompletionHandler?(nil, "")
        case .invalidActionCode:
            authCompletionHandler?(nil, "")
        case .invalidMessagePayload:
            authCompletionHandler?(nil, "")
        case .invalidSender:
            authCompletionHandler?(nil, "")
        case .invalidRecipientEmail:
            authCompletionHandler?(nil, "")
        case .missingEmail:
            authCompletionHandler?(nil, "")
        case .missingIosBundleID:
            authCompletionHandler?(nil, "")
        case .missingAndroidPackageName:
            authCompletionHandler?(nil, "")
        case .unauthorizedDomain:
            authCompletionHandler?(nil, "")
        case .invalidContinueURI:
            authCompletionHandler?(nil, "")
        case .missingContinueURI:
            authCompletionHandler?(nil, "")
        case .missingPhoneNumber:
            authCompletionHandler?(nil, "")
        case .invalidPhoneNumber:
            authCompletionHandler?(nil, "")
        case .missingVerificationCode:
            authCompletionHandler?(nil, "")
        case .invalidVerificationCode:
            authCompletionHandler?(nil, "")
        case .missingVerificationID:
            authCompletionHandler?(nil, "")
        case .invalidVerificationID:
            authCompletionHandler?(nil, "")
        case .missingAppCredential:
            authCompletionHandler?(nil, "")
        case .invalidAppCredential:
            authCompletionHandler?(nil, "")
        case .sessionExpired:
            authCompletionHandler?(nil, "")
        case .quotaExceeded:
            authCompletionHandler?(nil, "")
        case .missingAppToken:
            authCompletionHandler?(nil, "")
        case .notificationNotForwarded:
            authCompletionHandler?(nil, "")
        case .appNotVerified:
            authCompletionHandler?(nil, "")
        case .captchaCheckFailed:
            authCompletionHandler?(nil, "")
        case .webContextAlreadyPresented:
            authCompletionHandler?(nil, "")
        case .webContextCancelled:
            authCompletionHandler?(nil, "")
        case .appVerificationUserInteractionFailure:
            authCompletionHandler?(nil, "")
        case .invalidClientID:
            authCompletionHandler?(nil, "")
        case .webNetworkRequestFailed:
            authCompletionHandler?(nil, "")
        case .webInternalError:
            authCompletionHandler?(nil, "")
        case .webSignInUserInteractionFailure:
            authCompletionHandler?(nil, "")
        case .localPlayerNotAuthenticated:
            authCompletionHandler?(nil, "")
        case .nullUser:
            authCompletionHandler?(nil, "")
        case .dynamicLinkNotActivated:
            authCompletionHandler?(nil, "")
        case .invalidProviderID:
            authCompletionHandler?(nil, "")
        case .tenantIDMismatch:
            authCompletionHandler?(nil, "")
        case .unsupportedTenantOperation:
            authCompletionHandler?(nil, "")
        case .invalidDynamicLinkDomain:
            authCompletionHandler?(nil, "")
        case .rejectedCredential:
            authCompletionHandler?(nil, "")
        case .gameKitNotLinked:
            authCompletionHandler?(nil, "")
        case .secondFactorRequired:
            authCompletionHandler?(nil, "")
        case .missingMultiFactorSession:
            authCompletionHandler?(nil, "")
        case .missingMultiFactorInfo:
            authCompletionHandler?(nil, "")
        case .invalidMultiFactorSession:
            authCompletionHandler?(nil, "")
        case .multiFactorInfoNotFound:
            authCompletionHandler?(nil, "")
        case .adminRestrictedOperation:
            authCompletionHandler?(nil, "")
        case .unverifiedEmail:
            authCompletionHandler?(nil, "")
        case .secondFactorAlreadyEnrolled:
            authCompletionHandler?(nil, "")
        case .maximumSecondFactorCountExceeded:
            authCompletionHandler?(nil, "")
        case .unsupportedFirstFactor:
            authCompletionHandler?(nil, "")
        case .emailChangeNeedsVerification:
            authCompletionHandler?(nil, "")
        case .missingOrInvalidNonce:
            authCompletionHandler?(nil, "")
        case .missingClientIdentifier:
            authCompletionHandler?(nil, "")
        case .keychainError:
            authCompletionHandler?(nil, "")
        case .internalError:
            authCompletionHandler?(nil, "")
        case .malformedJWT:
            authCompletionHandler?(nil, "")
        @unknown default:
            authCompletionHandler?(nil, AuthenticationErrors.defaultMessage.rawValue)
        }
    }
}
