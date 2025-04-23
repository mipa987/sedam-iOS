//
//  NetworkError.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import Foundation

public enum NetworkError: Error {
    case urlNotFound
    case responseNotFound
    case invalidStatus(Int)
    case bindingFailure
}
