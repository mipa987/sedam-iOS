//
//  UserError.swift
//  Sedam
//
//  Created by 여성찬 on 4/27/25.
//

import Foundation

enum UserError: Error {
    case notLoggedIn
    case deleteUserError(reason: String?)
}
