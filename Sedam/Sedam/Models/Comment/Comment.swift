//
//  Post.swift
//  Sedam
//
//  Created by 여성찬 on 4/25/25.
//

import Foundation

struct Comment: Identifiable, Codable {
    let id: UUID
    var userId: UUID
    var postId: UUID
    var content: String
    var createdAt: String
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case postId = "post_id"
        case content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
