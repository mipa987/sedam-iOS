//
//  Term.swift
//  세담
//
//  Created by 여성찬 on 5/4/25.
//

import Foundation

struct Term: Codable {
    let id: UUID
    let title: String
    let version: Int
    let isRequired: Bool
    let created_at: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case version
        case isRequired = "is_required"
        case created_at
    }
}
