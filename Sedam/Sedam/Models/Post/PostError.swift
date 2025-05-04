//
//  PostError.swift
//  Sedam
//
//  Created by 여성찬 on 4/26/25.
//

import Foundation

enum PostError: Error {
    case notLoggedIn
    case creationFailed(reason: String?)
    case deletionFailed(reason: String?)
}
