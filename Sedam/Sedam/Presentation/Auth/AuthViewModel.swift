//
//  AuthViewModel.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    private let apple = AppleAuthManager()
    private let kakao = KakaoAuthManager()
    private let term = TermsService.shared
    
    @Published var authenticationState: AuthenticationState = .splash
    @Published var loginType: LogIn?
    @Published var istermsAgree = false
    
    init() {
        apple.onSuccess = { [weak self] idToken in
            Task {
                guard let self else {
                    return
                }
                
                do {
                    let session = try await SupabaseManager
                        .shared
                        .supabase
                        .auth
                        .signInWithIdToken(
                            credentials: .init(provider: .apple, idToken: idToken)
                        )
                    self.istermsAgree = try await TermsService.shared.hasAgreed(to: .privacyPolicy)
                    
                    if self.istermsAgree {
                        self.authenticationState = .signIn
                    } else {
                        self.authenticationState = .term
                    }
                    print("✅ Supabase 로그인 성공: \(session.user.email ?? "Unknown")")
                } catch {
                    print("❌ Supabase 로그인 실패:", error)
//                    self?.authenticationState = .failed(error)
                }
            }
        }
    }
    
    func send(type: LogIn) {
        switch type {
        case .kakao:
            Task {
                await kakao.trySignInWithKakoa()
                istermsAgree = try await term.hasAgreed(to: .privacyPolicy)
                
                if istermsAgree {
                    authenticationState = .signIn
                } else {
                    authenticationState = .term
                }
            }
        case .apple:
            apple.signInWithApple()
        }
    }
    
    func signOut() {
        Task {
            do {
                try await UserService().deleteUser()
                authenticationState = .splash
            } catch {
                print("❌ error: \(error.localizedDescription)")
            }
        }
    }
    
    func logOut(){
        Task {
            do {
                try await SupabaseManager.shared.supabase.auth.signOut()
                authenticationState = .splash
            } catch {
                print("❌ error: \(error.localizedDescription)")
            }
        }
    }
    
    func agreeTerms(to termName: TermName) {
        Task {
            do {
                try await term.agree(to: termName)
                authenticationState = .signIn
            } catch {
                print("❌ error: \(error.localizedDescription)")
            }
        }
    }
}
