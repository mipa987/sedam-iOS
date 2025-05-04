//
//  NewPost.swift
//  Sedam
//
//  Created by 여성찬 on 4/25/25.
//
import Foundation

struct NewLike: Codable {
    let postId: UUID
    let userId: UUID

    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case userId = "user_id"
    }
}
