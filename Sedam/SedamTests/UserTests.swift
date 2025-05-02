//
//  UserTest.swift
//  Sedam
//
//  Created by 여성찬 on 4/27/25.
//

import Foundation
import Testing

struct UserTest {
    @Test func example() async throws {
        // 1. 세션 강제 초기화 (로그아웃)
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

        // 3. Lambda를 통한 회원 삭제
        try await UserService.shared.deleteUser()
        print("✅ Lambda를 통한 회원 삭제 요청 성공")

        // 4. 삭제된 유저로 다시 로그인 시도 (로그인 실패해야 정상)
        do {
            _ = try await SupabaseManager.shared.supabase.auth.signIn(
                email: email,
                password: password
            )
            throw TestError(message: "❌ 삭제된 유저로 로그인에 성공해버렸습니다 (에러가 발생해야 정상)")
        } catch {
            print("✅ 삭제된 유저는 로그인 실패 확인 완료")
        }
    }
}
