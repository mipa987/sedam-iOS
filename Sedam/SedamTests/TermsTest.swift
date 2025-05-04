//
//  TermsTest.swift
//  세담
//
//  Created by 여성찬 on 5/4/25.
//
import Foundation
import Testing

struct TermsTest {
    func testAgreeToTerms() async throws {
        try? await SupabaseManager.shared.supabase.auth.signOut()

        guard
            let email = Bundle.main.object(forInfoDictionaryKey: "TEST_EMAIL") as? String,
            let password = Bundle.main.object(forInfoDictionaryKey: "TEST_PASSWORD") as? String
        else {
            throw TestError(message: "❌ 테스트 계정 정보 불러오기 실패 (plist 확인 필요)")
        }

        let authResponse = try await SupabaseManager.shared.supabase.auth.signIn(
            email: email,
            password: password
        )
        print("✅ 로그인 성공: \(authResponse.user.email ?? "")")

        let termService = TermsService.shared
        let term = TermName.privacyPolicy

        let hasAgreed = try await termService.hasAgreed(to: term)
        if hasAgreed {
            print("⚠️ 이미 해당 약관에 동의함, 테스트를 위해 동의 삭제 필요")
            return
        }

        try await termService.agree(to: term)
        print("✅ 약관 동의 성공")

        let confirmed = try await termService.hasAgreed(to: term)
        #expect(confirmed, "❌ 약관 동의 후 확인 실패")
        print("✅ 약관 동의 상태 확인 성공")
    }
}
