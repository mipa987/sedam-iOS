//
//  TodayWord.swift
//  Sedam
//
//  Created by 여성찬 on 4/29/25.
//

import Foundation

struct TodayWord: Codable {
    let id: UUID
    let word: String

    enum CodingKeys: String, CodingKey {
        case id
        case word
    }
}
