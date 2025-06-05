//
//  AuthViewModel.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import Combine
import SwiftUI
import Supabase

@MainActor
class AuthViewModel: ObservableObject {
    private let networkManager: NetworkManager
    private let apple = AppleAuthManager()
    private let kakao = KakaoAuthManager()
    private let term: TermsService
    private let client = SupabaseManager.shared.supabase
    
    @Published var authenticationState: AuthenticationState = .splash {
        didSet {
            if authenticationState == .splash {
                isLogInPresented = true
            } else if authenticationState == .term {
                isLogInPresented = false
                isTermPresented = true
            } else {
                isLogInPresented = false
                isTermPresented = false
            }
        }
    }
    @Published var loginType: LogIn?
    @Published var istermsAgree = false
    @Published var isLogInPresented: Bool = true
    @Published var isTermPresented: Bool = false
    @Published var showLogInPopUp: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.term = TermsService(networkManager: networkManager)
        
        updatePresentationFlags()
        NotificationCenter.default
            .publisher(for: .loginRequired)
            .sink { [weak self] _ in
                withAnimation {
                    self?.showLogInPopUp = true
                }
            }
            .store(in: &cancellables)
        
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
                    print("accessToken: \(session.accessToken)")
                    
                    KeyChainModule.create(key: .accessToken, data: session.accessToken)
                    KeyChainModule.create(key: .refreshToken, data: session.refreshToken)
                    
                    self.istermsAgree = try await TermsService(networkManager: networkManager).hasAgreed(to: .privacyPolicy)
                    
                    if self.istermsAgree {
                        self.authenticationState = .signIn
                    } else {
                        self.authenticationState = .term
                    }
                    print("✅ Supabase 로그인 성공: \(session.user.email ?? "Unknown")")
                } catch {
                    print("❌ Supabase 로그인 실패:", error.localizedDescription)
                    //                    self?.authenticationState = .failed(error)
                }
            }
        }
    }
    
    private func updatePresentationFlags() {
        if KeyChainModule.read(key: .accessToken) == nil {
            authenticationState = .splash
        }
        
        // 세션이 있지만 약관 동의 정보가 없다면 약관 화면 띄우기
        Task {
            do {
                istermsAgree = try await term.hasAgreed(to: .privacyPolicy)
                if istermsAgree {
                    authenticationState = .signIn
                } else {
                    authenticationState = .term
                }
            } catch NetworkError.accessDenied {
                authenticationState = .splash
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
                try await UserService(networkManager: networkManager).deleteUser()
                KeyChainModule.delete(key: .accessToken)
                KeyChainModule.delete(key: .refreshToken)
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
                KeyChainModule.delete(key: .accessToken)
                KeyChainModule.delete(key: .refreshToken)
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
                _ = try await UserService(networkManager: networkManager).createRandomNickname()
                authenticationState = .signIn
            } catch {
                print("❌ error: \(error.localizedDescription)")
            }
        }
    }
}
