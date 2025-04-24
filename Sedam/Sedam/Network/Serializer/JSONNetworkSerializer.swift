//
//  JSONNetworkSerializer.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import Foundation

public struct JSONNetworkSerializer: NetworkSerializable {
    public init() {}
    
    public func serialize(_ parameters: [String: Any]) throws -> Data {
        try JSONSerialization.data(withJSONObject: parameters)
    }
}
