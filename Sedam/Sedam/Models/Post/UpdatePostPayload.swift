//
//  UpdatePost.swift
//  Sedam
//
//  Created by 여성찬 on 5/2/25.
//
import Foundation

struct UpdatePostPayload: Codable {
    let title: String
    let content: String
    let updated_at: String
}
