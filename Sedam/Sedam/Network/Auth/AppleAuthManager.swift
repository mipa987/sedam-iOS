//
//  AppleAuthManager.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import AuthenticationServices
import Supabase
import SwiftUI

final class AppleAuthManager: NSObject, ASAuthorizationControllerDelegate {
    var onSuccess: ((String) -> Void)?
    var onFailure: ((Error) -> Void)?
    
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
        
        onSuccess?(idToken)
        
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("❌ Apple 로그인 에러:", error.localizedDescription)
    }
}
