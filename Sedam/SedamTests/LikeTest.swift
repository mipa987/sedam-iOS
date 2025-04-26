//
//  Likes.swift
//  Sedam
//
//  Created by 여성찬 on 4/26/25.
//

import Foundation
import Testing

// TODO: supabase 확인후, MOCK 으로 구현
struct LikeTest {
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

        let likeService = LikeService.shared
        let postService = PostService.shared

        let authResponse = try await SupabaseManager.shared.supabase.auth.signIn(
            email: email,
            password: password
        )

        print("✅ 로그인 성공: \(authResponse.user.email ?? "")")

        // 3. 게시글 하나 가져오기
        guard let post = try await postService.fetchAllPosts().first else {
            throw TestError(message: "❌ 게시글이 없습니다")
        }
        print("✅ 테스트용 게시글 가져오기 성공: \(post.id)")

        // 4. 좋아요 누르기 테스트
        try await likeService.like(postId: post.id)
        print("✅ 좋아요 누르기 성공")

        // 5. 좋아요 했는지 여부 확인
        let hasLiked = try await likeService.hasLiked(postId: post.id)
        #expect(hasLiked, "❌ 좋아요 누른 상태가 아님")
        print("✅ 좋아요 여부 확인 성공")

        // 6. 좋아요 취소하기 테스트
        try await likeService.unlike(postId: post.id)
        print("✅ 좋아요 취소 성공")

        // 7. 다시 좋아요 여부 확인
        let hasLikedAfterUnlike = try await likeService.hasLiked(postId: post.id)
        #expect(!hasLikedAfterUnlike, "❌ 좋아요가 삭제되지 않았음")
        print("✅ 좋아요 삭제 여부 확인 성공")
    }
}
