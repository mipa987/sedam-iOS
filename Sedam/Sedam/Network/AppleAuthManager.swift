////
////  AppleAuthManager.swift
////  Sedam
////
////  Created by minsong kim on 4/23/25.
////
//
import AuthenticationServices
import Supabase

final class AppleAuthManager: NSObject, ASAuthorizationControllerDelegate {
    let supabase = SupabaseClient(
    )
    
    func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard
            let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let tokenData = credential.identityToken,
            let idToken = String(data: tokenData, encoding: .utf8)
        else {
            print("❌ Apple ID Token 추출 실패")
            return
        }

        Task {
            do {
                let session = try await supabase.auth.signInWithIdToken(
                    credentials: .init(provider: .apple, idToken: idToken)
                )
                DispatchQueue.main.async {
                    print("✅ Supabase 로그인 성공: \(session.user.email ?? "Unknown")")
                }
            } catch {
                print("❌ Supabase 로그인 실패:", error)
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("❌ Apple 로그인 에러:", error.localizedDescription)
    }
}
