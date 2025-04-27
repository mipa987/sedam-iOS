//
//  CommentTests.swift
//  Sedam
//
//  Created by 여성찬 on 4/26/25.
//

import Foundation
import Testing

// TODO: supabase 확인후, MOCK 으로 구현
struct CommentTest {
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

        let commentService = CommentService.shared
        let postService = PostService.shared

        let authResponse = try await SupabaseManager.shared.supabase.auth.signIn(
            email: email,
            password: password
        )

        // 3. 게시글 하나 가져오기
        guard let post = try await postService.fetchAllPosts().first else {
            throw TestError(message: "❌ 게시글이 없습니다")
        }
        print("✅ 테스트용 게시글 가져오기 성공: \(post.id)")

        // 4. 댓글 생성 테스트
        let originalContent = "Test Comment \(UUID().uuidString.prefix(4))"
        try await commentService.createComment(postId: post.id, content: originalContent)
        print("✅ 댓글 생성 성공: \(originalContent)")

        // 5. 댓글 조회 테스트
        let comments = try await commentService.fetchComments(for: post.id)
        guard let createdComment = comments.first(where: { $0.content == originalContent }) else {
            throw TestError(message: "❌ 생성한 댓글을 찾을 수 없음")
        }
        print("✅ 생성한 댓글 조회 성공: \(createdComment.id)")

        // 6. 댓글 수정 테스트
        let updatedContent = "Updated Comment \(UUID().uuidString.prefix(4))"
        try await commentService.updateComment(id: createdComment.id, newContent: updatedContent)
        print("✅ 댓글 수정 성공: \(updatedContent)")

        // 7. 수정된 댓글 조회 확인
        let updatedComments = try await commentService.fetchComments(for: post.id)
        guard updatedComments.contains(where: { $0.content == updatedContent }) else {
            throw TestError(message: "❌ 수정된 댓글을 찾을 수 없음")
        }
        print("✅ 수정된 댓글 조회 성공")

        // 8. 댓글 삭제 테스트
        try await commentService.deleteComment(id: createdComment.id)
        print("✅ 댓글 삭제 성공")

        // 9. 삭제된 댓글 조회 확인
        let finalComments = try await commentService.fetchComments(for: post.id)
        guard !finalComments.contains(where: { $0.id == createdComment.id }) else {
            throw TestError(message: "❌ 삭제된 댓글이 여전히 존재함")
        }
        print("✅ 댓글 삭제 확인 성공")
    }
}
