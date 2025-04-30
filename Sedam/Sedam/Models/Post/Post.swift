//
//  Post.swift
//  Sedam
//
//  Created by 여성찬 on 4/25/25.
//

import Foundation

struct Post: Identifiable, Codable, Hashable {
    let id: UUID
    var userId: UUID
    var title: String
    var content: String
    var likes: Int
    var createdAt: String // <-- String으로
    var updatedAt: String? // <-- String으로

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id" // <- 여기도 매핑 추가해야 해
        case title
        case content
        case likes
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
