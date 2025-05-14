//
//  LikeService.swift
//  Sedam
//
//  Created by 여성찬 on 4/26/25.
//

import Foundation

final class LikeService {
    static let shared = LikeService()
    private let networkManager = NetworkManager()

    private init() {}

    // ✅ 좋아요 누르기
    func like(postId: String) async throws {
        let builder = LikeBuilder(http: .post, postID: postId)
        
        _ = try await networkManager.fetchData(builder)
    }

    // ✅ 좋아요 취소하기
    func unlike(postId: String) async throws {
        let builder = LikeBuilder(http: .delete, postID: postId)
        
        _ = try await networkManager.fetchData(builder)
    }

    // 현재 유저가 이 포스트에 좋아요 눌렀는지 여부
    func hasLiked(postId: String) async throws -> Bool {
        let builder = CheckLikeBuilder(postId: postId)
        
        return try await networkManager.fetchData(builder) == "true"
    }
}
