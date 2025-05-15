//
//  NetworkSerializable.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

protocol NetworkSerializable {
    func serialize(_ parameters: [String: Any]) async throws -> Data
}
