//
//  PathURLType.swift
//  Sedam
//
//  Created by minsong kim on 5/16/25.
//

enum PathURLType {
    case post
    case myPost
    case onePost
    case likes
    case checkLiked
    case todayWord
    case todayWordByDate
    case terms
    case userNickname
    case userNicknameCreate
    case userDelete
    
    func path() -> String {
        switch self {
        case .post:
            return "/api/v1/posts"
        case .myPost:
            return "/api/v1/posts/my"
        case .onePost:
            return "/api/v1/posts"
        case .likes:
            return "/api/v1/likes"
        case .checkLiked:
            return "/api/v1/likes/check_liked"
        case .todayWord:
            return "/api/v1/today-words/today"
        case .todayWordByDate:
            return "/api/v1/today-words/by-date"
        case .terms:
            return "/api/v1/terms"
        case .userNickname:
            return "/api/v1/users/nickname"
        case .userNicknameCreate:
            return "/api/v1/users/nickname/random"
        case .userDelete:
            return "/api/v1/users/me"
        }
    }
}
