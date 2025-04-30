//
//  AuthViewModel.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import Combine
import SwiftUI
import KeyChainModule

class AuthViewModel: ObservableObject {
     enum Action {
         case kakaoSignIn
         case appleSignIn
         case checkToken
     }
     
    private var cancellables = Set<AnyCancellable>()
    private let apple = AppleAuthManager()
    private let kakao = KakaoAuthManager()

    @Published var authenticationState: AuthenticationState = .splash
    @Published var loginType: LogIn?
    @Published var userEmail: String?
    @Published var isLoggedIn = false
    
    @MainActor
    func send(action: Action) {
        switch action {
        case .checkToken:
            return
        case .kakaoSignIn:
            Task {
                await kakao.trySignInWithKakoa()
                
                self.authenticationState = .signIn
            }
        case .appleSignIn:
            apple.signInWithApple()
            
            self.loginType = .apple
            self.authenticationState = .signIn
        }
    }
}
