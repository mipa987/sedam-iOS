//
//  PostDetailBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/13/25.
//

import Foundation

struct PostDetailBuilder: BuilderProtocol {
    typealias Response = [PostDTO]
    
    var baseURL: BaseURLType { .production }
    var path: String = "/posts"
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())
    
    var useAuthorization: Bool
    
    init(httpMethod: HTTPMethod, id: String) {
        method = httpMethod
        path += "/\(id)"
        
        if httpMethod == .get {
            useAuthorization = false
        } else {
            useAuthorization = true
        }
    }
}
