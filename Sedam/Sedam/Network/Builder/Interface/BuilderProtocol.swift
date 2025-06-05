//
//  BuilderProtocol.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

protocol BuilderProtocol {
    associatedtype Response: Decodable
    
    var path: String { get }
    var queries: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var serializer: NetworkSerializable { get }
    var deserializer: NetworkDeserializable { get }

    var useAuthorization: Bool { get }
}

extension BuilderProtocol {
    var headers: [String: String] { ["Content-Type": "application/json"] }

    var serializer: NetworkSerializable {
        JSONNetworkSerializer()
    }
}
