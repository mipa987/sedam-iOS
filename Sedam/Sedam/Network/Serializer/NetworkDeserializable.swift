//
//  NetworkDeserializable.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import Foundation

public protocol NetworkDeserializable {
    func deserialize<T: Decodable>(_ data: Data) async throws -> T
}
