//
//  SedamTests.swift
//  SedamTests
//
//  Created by minsong kim on 4/25/25.
//

import Foundation
import Testing

struct TestError: Error {
    let message: String
}

struct SedamTests {
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

        let postService = PostService()

        let authResponse = try await SupabaseManager.shared.supabase.auth.signIn(
            email: email,
            password: password
        )
        print("✅ 로그인 성공: \(authResponse.user.email ?? "")")

        // 3. posts 삽입 테스트
        let title = "Test Title \(UUID().uuidString.prefix(5))"
        let content = "Test Content"

        do {
            try await postService.createPost(title: title, content: content)
            print("✅ 포스트 생성 성공", title, content)
        } catch {
            throw TestError(message: "❌ 포스트 생성 실패: \(error.localizedDescription)")
        }

        // 4. posts 조회 테스트
        do {
            let posts = try await postService.fetchAllPosts()

            #expect(!posts.isEmpty, "❌ posts 리스트가 비어있음")
            print("✅ 포스트 조회 성공, 총 \(posts.count)개")

            guard let createdPost = posts.first(where: { $0.title == title }) else {
                throw TestError(message: "❌ 생성한 포스트를 찾을 수 없음")
            }
            print("✅ 생성한 포스트 찾음: \(createdPost.id)")

            // 5. post 삭제 테스트
            do {
                try await postService.deletePost(id: createdPost.id)
                print("✅ 생성한 포스트 삭제 성공:", createdPost.id)
            } catch {
                throw TestError(message: "❌ 포스트 삭제 실패: \(error.localizedDescription)")
            }

        } catch {
            throw TestError(message: "❌ 포스트 조회 실패: \(error.localizedDescription)")
        }
    }
}
