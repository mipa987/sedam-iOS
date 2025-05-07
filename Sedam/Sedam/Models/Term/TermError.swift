//
//  UserError.swift
//  세담
//
//  Created by 여성찬 on 5/4/25.
//

import Foundation

enum TermError: Error {
    case notLoggedIn
    case cannotFindTerm
    case alreadyAgreed
}
