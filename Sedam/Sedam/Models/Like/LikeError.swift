//
//  PostError.swift
//  Sedam
//
//  Created by 여성찬 on 4/26/25.
//

import Foundation

enum LikeError: Error {
    case notLoggedIn
    case likeFailed(reason: String?)
    case unlikeFailed(reason: String?)
}
