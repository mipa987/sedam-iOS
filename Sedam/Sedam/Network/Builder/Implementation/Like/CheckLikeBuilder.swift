//
//  CheckLikeBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct CheckLikeBuilder: BuilderProtocol {
    typealias Response = LikeCheckDTO
    
    var baseURL: BaseURLType { .production }
    var path: String = PathURLType.checkLiked.path()
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .get }
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { true }
    
    init(postId: String) {
        path += "/\(postId)"
    }
}
