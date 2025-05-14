//
//  LikeService.swift
//  Sedam
//
//  Created by 여성찬 on 4/26/25.
//

import Foundation

final class LikeService {
    static let shared = LikeService()
    private let client = SupabaseManager.shared.supabase

    private init() {}

    // ✅ 좋아요 누르기
    func like(postId: String) async throws {
//        guard let userId = SupabaseManager.shared.supabase.auth.currentUser?.id else {
//            throw LikeError.notLoggedIn
//        }
//
//        let newLike = NewLike(postId: postId, userId: userId)
//
//        let response = try await client
//            .from("likes")
//            .insert(newLike)
//            .execute()
//
//        guard (200...299).contains(response.status) else {
//            throw LikeError.likeFailed(reason: response.string())
//        }
    }

    // ✅ 좋아요 취소하기
    func unlike(postId: String) async throws {
        guard let userId = SupabaseManager.shared.supabase.auth.currentUser?.id else {
            throw LikeError.notLoggedIn
        }

        let response = try await client
            .from("likes")
            .delete()
            .eq("post_id", value: postId)
            .eq("user_id", value: userId)
            .execute()

        guard (200...299).contains(response.status) else {
            throw LikeError.unlikeFailed(reason: response.string())
        }
    }

    // 현재 유저가 이 포스트에 좋아요 눌렀는지 여부
    func hasLiked(postId: String) async throws -> Bool {
        guard let userId = SupabaseManager.shared.supabase.auth.currentUser?.id else {
            throw LikeError.notLoggedIn
        }

        let likes: [Like] = try await client
            .from("likes")
            .select()
            .eq("post_id", value: postId)
            .eq("user_id", value: userId)
            .execute()
            .value

        return !likes.isEmpty
    }
}
