//
//  PostOrder.swift
//  Sedam
//
//  Created by 여성찬 on 5/2/25.
//
import Foundation

enum PostOrder: String {
    case latest = "created_at"
    case popular = "likes"

    var description: String {
        switch self {
        case .latest: return "최신순"
        case .popular: return "좋아요순"
        }
    }
}
