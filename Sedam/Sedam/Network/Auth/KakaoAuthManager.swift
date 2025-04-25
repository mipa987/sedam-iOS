//
//  KakaoAuthManager.swift
//  Sedam
//
//  Created by minsong kim on 4/24/25.
//

import AuthenticationServices
import Foundation
import Supabase

public class KakaoAuthManager {
    private var currentSession: ASWebAuthenticationSession?
    private var currentContextProvider: ASWebAuthenticationPresentationContextProviding?
    
    @MainActor
    func trySignInWithKakoa() async {
        do {
            try await SupabaseManager.shared.supabase.auth.signInWithOAuth(
                provider: .kakao,
                redirectTo: URL(string: "sedam://auth/callback")
            ) { url in
                try await launchWebAuthSession(with: url)
            }
            
            debugPrint("✅ Kakao 로그인 성공")
        } catch {
            debugPrint("❌ Kakao 로그인 실패: (error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    private func launchWebAuthSession(with url: URL) async throws -> URL {
        try await withCheckedThrowingContinuation { c in
            let contextProvider = WebAuthPresentationContextProvider()
            let session = ASWebAuthenticationSession(
                url: url,
                callbackURLScheme: "sedam" 
            ) { callbackURL, error in
                // 세션 끝났으니 보관 참조 해제
                self.currentSession = nil
                self.currentContextProvider = nil
                
                if let error { c.resume(throwing: error) }
                else if let callbackURL { c.resume(returning: callbackURL) }
                else { c.resume(throwing: URLError(.badServerResponse)) }
            }
            
            session.presentationContextProvider = contextProvider
            session.prefersEphemeralWebBrowserSession = true
            
            // 🔒 retain
            self.currentSession = session
            self.currentContextProvider = contextProvider
            
            session.start()
        }
    }
}

@MainActor
final class WebAuthPresentationContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow } ?? UIWindow()
    }
}
