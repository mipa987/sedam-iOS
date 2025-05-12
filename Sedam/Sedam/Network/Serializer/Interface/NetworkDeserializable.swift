//
//  NetworkDesereailizable.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

protocol NetworkDeserializable {
    func deserialize<T: Decodable>(_ data: Data) async throws -> T
}
