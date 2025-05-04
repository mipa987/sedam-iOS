//
//  NewPost.swift
//  Sedam
//
//  Created by 여성찬 on 4/25/25.
//
import Foundation

struct NewPost: Codable {
    var userId: UUID
    var title: String
    var content: String
    var likes: Int = 0

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case title
        case content
        case likes
    }
}
