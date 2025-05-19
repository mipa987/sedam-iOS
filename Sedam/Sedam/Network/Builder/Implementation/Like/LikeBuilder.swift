//
//  LikeBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct LikeBuilder: BuilderProtocol {
    typealias Response = ResponseDTO
    
    var baseURL: BaseURLType { .production }
    var path: String = PathURLType.likes.path()
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { true }
    
    init(http: HTTPMethod, postID: String) {
        method = http
        self.path += "/\(postID)"
    }
}
