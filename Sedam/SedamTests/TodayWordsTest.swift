//
//  Test.swift
//  SedamTests
//
//  Created by 여성찬 on 4/29/25.
//

import Foundation
import Testing

struct TodayWordTest {
    @Test func example() async throws {
        // 1. 세션 초기화 (로그아웃)
        try? await SupabaseManager.shared.supabase.auth.signOut()

        // 2. 테스트용 유저 로그인
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

        // 3. 오늘의 단어 조회
        let todayWordService = TodayWordService.shared

        let words = try await todayWordService.fetchTodayWords() // ✅ [String] 리스트로 받음

        #expect(!words.isEmpty, "❌ 오늘의 단어 리스트가 비어있음")
        print("✅ 오늘의 단어 조회 성공:", words)
    }
}
