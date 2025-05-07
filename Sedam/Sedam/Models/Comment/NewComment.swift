//
//  NewPost.swift
//  Sedam
//
//  Created by 여성찬 on 4/25/25.
//
import Foundation

struct NewComment: Codable {
    var userId: UUID
    var postId: UUID
    var content: String

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case postId = "post_id"
        case content
    }
}
