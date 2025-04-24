//
//  NetworkBuilderProtocol.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import Foundation

public protocol NetworkBuilderProtocol {
    associatedtype Response: Decodable

    var baseURL: BaseURLType { get }
    var path: String { get }
    var queries: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var serializer: NetworkSerializable { get }
    var deserializer: NetworkDeserializable { get }

    var useAuthorization: Bool { get }
}

public extension NetworkBuilderProtocol {
    var headers: [String: String] { ["Content-Type": "application/json"] }

    var serializer: NetworkSerializable {
        JSONNetworkSerializer()
    }
}
