//
//  JSONNetworkSerializer.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct JSONNetworkSerializer: NetworkSerializable {
    init() {}
    
    func serialize(_ parameters: [String: Any]) throws -> Data {
        try JSONSerialization.data(withJSONObject: parameters)
    }
}
