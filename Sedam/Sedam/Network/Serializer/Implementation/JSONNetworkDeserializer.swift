//
//  JSONNetworkDeserializer.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct JSONNetworkDeserializer: NetworkDeserializable {
    let decoder: JSONDecoder

    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    func deserialize<T: Decodable>(_ data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
