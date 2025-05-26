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
    
    private let isoFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // 1) 고정 포맷 파싱용 POSIX 로케일
        formatter.locale = Locale.current
        // 2) 서버 문자열이 UTC 기준이라면 그대로
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        return formatter
    }()
    
    var createdAtDate: Date? {
        return isoFormatter.date(from: createdAt)
    }
    
    var updatedAtDate: Date? {
        return isoFormatter.date(from: updatedAt)
    }
}
