//
//  PostDTO.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct PostDTO: Decodable {
    let id: String
    let title: String
    let content: String
    let userID: String
    let userNickname: String
    let createdAt: String
    let updatedAt: String
    var likes: Int
    let todayWords: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case userID = "user_id"
        case userNickname = "user_nickname"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case likes
        case todayWords = "today_words"
    }
}
