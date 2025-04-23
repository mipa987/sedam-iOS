//
//  NetworkSerializable.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import Foundation

public protocol NetworkSerializable {
    func serialize(_ parameters: [String: Any]) async throws -> Data
}
