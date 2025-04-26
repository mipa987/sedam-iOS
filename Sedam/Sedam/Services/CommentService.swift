//
//  CommentService.swift
//  Sedam
//
//  Created by 여성찬 on 4/26/25.
//

import Foundation
import Supabase

final class CommentService {
    static let shared = CommentService()

    private let client = SupabaseManager.shared.supabase

    // ✏️ comment 생성
    func createComment(postId: UUID, content: String) async throws {
        guard let userId = SupabaseManager.shared.supabase.auth.currentUser?.id else { throw CommentError.notLoggedIn
        }

        let newComment = NewComment(userId: userId, postId: postId, content: content)
        let response = try await client
            .from("comments")
            .insert(newComment)
            .execute()

        guard (200 ... 299).contains(response.status) else {
            throw CommentError.creationFailed(reason: response.string())
        }
    }

    // 📄 특정 post에 대한 comments 가져오기
    func fetchComments(for postId: UUID) async throws -> [Comment] {
        try await client
            .from("comments")
            .select()
            .eq("post_id", value: postId)
            .order("created_at", ascending: true)
            .execute()
            .value
    }

    // comment 수정
    func updateComment(id: UUID, newContent: String) async throws {
        guard let userId = SupabaseManager.shared.supabase.auth.currentUser?.id else {
            throw PostError.notLoggedIn
        }

        let response = try await client
            .from("comments")
            .update(["content": newContent])
            .eq("id", value: id)
            .eq("user_id", value: userId)
            .execute()

        guard (200 ... 299).contains(response.status) else {
            throw CommentError.updateFailed(reason: response.string())
        }
    }

    // comment 삭제
    func deleteComment(id: UUID) async throws {
        guard let userId = SupabaseManager.shared.supabase.auth.currentUser?.id else { throw CommentError.notLoggedIn
        }
        let response = try await client
            .from("comments")
            .delete()
            .eq("id", value: id.uuidString)
            .eq("user_id", value: userId)
            .execute()

        guard (200 ... 299).contains(response.status) else {
            throw CommentError.deletionFailed(reason: response.string())
        }
    }
}
