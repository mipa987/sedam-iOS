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

// TODO: supabase 확인후, MOCK 으로 구현
struct PostTest {
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

        let postService = PostService.shared

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

            // 5. 내 포스트 조회 테스트
            do {
                let myPosts = try await postService.fetchMyPosts()
                #expect(myPosts.contains(where: { $0.title == title }), "❌ 내 포스트 목록에 생성한 포스트가 없음")
                print("✅ 내 포스트 조회 성공, 총 \(myPosts.count)개")
            } catch {
                throw TestError(message: "❌ 내 포스트 조회 실패: \(error.localizedDescription)")
            }

            // 5. post 수정 테스트
            let updatedTitle = "Updated Title"
            let updatedContent = "Updated Content"
            do {
                try await postService.updatePost(id: createdPost.id, title: updatedTitle, content: updatedContent)
                print("✅ 포스트 수정 성공")

                let updatedPost = try await postService.fetchPost(by: createdPost.id)
                #expect(updatedPost.title == updatedTitle, "❌ 제목 수정 안 됨")
                #expect(updatedPost.content == updatedContent, "❌ 내용 수정 안 됨")
                print("✅ 포스트 수정 결과 확인 완료")
            } catch {
                throw TestError(message: "❌ 포스트 수정 실패: \(error.localizedDescription)")
            }

            // 6. 좋아요 순 정렬 테스트
            do {
                let sortedPosts = try await postService.fetchAllPosts(orderBy: .popular)
                #expect(!sortedPosts.isEmpty, "❌ 좋아요순 정렬 실패 또는 결과 없음")
                print("✅ 좋아요순 정렬 성공, 첫 포스트: \(sortedPosts.first!.id) \(sortedPosts.first!.likes)")
            } catch {
                throw TestError(message: "❌ 좋아요순 정렬 테스트 실패: \(error.localizedDescription)")
            }

            // 7. 최신순  정렬 테스트
            do {
                let sortedPosts = try await postService.fetchAllPosts(orderBy: .latest)
                #expect(!sortedPosts.isEmpty, "❌ 최신순 정렬 실패 또는 결과 없음")
                print("✅ 최신순 정렬 성공, 첫 포스트: \(sortedPosts.first!.id) \(sortedPosts.first!.likes)")
            } catch {
                throw TestError(message: "❌ 최신순 정렬 테스트 실패: \(error.localizedDescription)")
            }

            // 7. post 삭제 테스트
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
