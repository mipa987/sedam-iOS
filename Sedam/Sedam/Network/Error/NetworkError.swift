//
//  NetworkError.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

enum NetworkError: Error {
    case urlNotFound
    case responseNotFound
    case invalidStatus(Int)
    case bindingFailure
}
