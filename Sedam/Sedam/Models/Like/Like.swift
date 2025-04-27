//
//  Like.swift
//  Sedam
//
//  Created by 여성찬 on 4/26/25.
//

import Foundation

struct Like: Identifiable, Codable {
    let id: UUID
    let postId: UUID
    let userId: UUID
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case postId = "post_id"
        case userId = "user_id"
        case createdAt = "created_at"
    }
}
