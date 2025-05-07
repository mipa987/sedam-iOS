//
//  UserTerm 2.swift
//  세담
//
//  Created by 여성찬 on 5/4/25.
//
import Foundation

struct UserTerm: Codable {
    let id: UUID
    let userId: UUID
    let termsId: UUID
    let agreedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case termsId = "terms_id"
        case agreedAt = "agreed_at"
    }
}
