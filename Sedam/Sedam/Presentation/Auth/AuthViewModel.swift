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
    private let kakao = KakaoAuthManager()

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
            Task {
                await kakao.trySignInWithKakoa()
            }
        case .appleSignIn:
            apple.signInWithApple()
            
            self.loginType = .apple
            self.authenticationState = .term
        }
    }
}
