//
//  AuthViewModel.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    private let apple = AppleAuthManager()
    private let kakao = KakaoAuthManager()
    
    @Published var authenticationState: AuthenticationState = .splash
    @Published var loginType: LogIn?
    @Published var isLoggedIn = false
    
    init() {
        apple.onSuccess = { [weak self] idToken in
            Task { @MainActor in
                do {
                    let session = try await SupabaseManager
                        .shared
                        .supabase
                        .auth
                        .signInWithIdToken(
                            credentials: .init(provider: .apple, idToken: idToken)
                        )
                    self?.authenticationState = .term
                    print("✅ Supabase 로그인 성공: \(session.user.email ?? "Unknown")")
                } catch {
                    print("❌ Supabase 로그인 실패:", error)
//                    self?.authenticationState = .failed(error)
                }
            }
        }
    }
    
    @MainActor
    func send(type: LogIn) {
        switch type {
        case .kakao:
            Task {
                await kakao.trySignInWithKakoa()
                
                authenticationState = .term
            }
        case .apple:
            apple.signInWithApple()
        }
    }
    
    @MainActor
    func logIn() {
        authenticationState = .signIn
    }
}
