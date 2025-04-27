//
//  PostService.swift
//  Sedam
//
//  Created by 여성찬 on 4/25/25.
//

import Foundation
import Supabase

final class PostService {
    static let shared = PostService()

    private let client = SupabaseManager.shared.supabase
    // 모든 post 불러오기
    func fetchAllPosts() async throws -> [Post] {
        try await client
            .from("posts")
            .select()
            .order("likes", ascending: false)
            .execute()
            .value
    }

    // 단일 post 조회
    func fetchPost(by id: UUID) async throws -> Post {
        try await client
            .from("posts")
            .select()
            .eq("id", value: id.uuidString)
            .single()
            .execute()
            .value
    }

    // post 생성
    func createPost(title: String, content: String) async throws {
        guard let userId = SupabaseManager.shared.supabase.auth.currentUser?.id else {
            throw PostError.notLoggedIn
        }

        let newPost = NewPost(userId: userId, title: title, content: content)

        let response = try await client
            .from("posts")
            .insert(newPost)
            .execute()

        guard (200 ... 299).contains(response.status) else {
            throw PostError.creationFailed(reason: response.string())
        }
    }

    // post 삭제
    func deletePost(id: UUID) async throws {
        guard let userId = SupabaseManager.shared.supabase.auth.currentUser?.id else {
            throw PostError.notLoggedIn
        }
        let response = try await client
            .from("posts")
            .delete()
            .eq("id", value: id.uuidString)
            .eq("user_id", value: userId)
            .execute()

        guard (200 ... 299).contains(response.status) else {
            throw PostError.deletionFailed(reason: response.string())
        }
    }

    // TODO: 좋아요 수 변경
    // TODO: Post 삭제하면 댓글 삭제
    // TODO: 중복 좋아요 수 처리
}
