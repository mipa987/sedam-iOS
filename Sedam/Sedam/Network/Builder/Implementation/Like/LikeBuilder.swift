//
//  LikeBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct LikeBuilder: BuilderProtocol {
    typealias Response = String
    
    var baseURL: BaseURLType { .production }
    var path: String = "/likes"
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { true }
    
    init(http: HTTPMethod) {
        method = http
    }
}
