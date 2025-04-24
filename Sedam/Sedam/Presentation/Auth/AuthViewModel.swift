//
//  AuthViewModel.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import Combine
import SwiftUI
import KeyChainModule

@Observable
class AuthViewModel {
     enum Action {
         case kakaoSignIn
         case appleSignIn
         case checkToken
     }
     
    private var cancellables = Set<AnyCancellable>()
    private let apple = AppleAuthManager()

    var authenticationState: AuthenticationState = .splash
    var loginType: LogIn?
    var userEmail: String?
    var isLoggedIn = false
    
    @MainActor
    func send(action: Action) {
        switch action {
        case .checkToken:
            return
        case .kakaoSignIn:
            return
        case .appleSignIn:
            apple.signInWithApple()
            
            self.loginType = .apple
            self.authenticationState = .term
        }
    }
}
