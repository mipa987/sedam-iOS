//
//  PostDetailBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/13/25.
//

import Foundation

struct PostDetailBuilder <T: Decodable>: BuilderProtocol {
    typealias Response = T
    
    var path: String = PathURLType.onePost.path()
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod
    let parameters: [String: Any]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())
    
    var useAuthorization: Bool
    
    init(httpMethod: HTTPMethod, id: String) {
        method = httpMethod
        path += "/\(id)"
        parameters = [:]
        
        if httpMethod == .get {
            useAuthorization = false
        } else {
            useAuthorization = true
        }
    }
    
    init(id: String, parameters: [String: Any]) {
        method = .patch
        path += "/\(id)"
        useAuthorization = true
        self.parameters = parameters
        self.queries =
        [
            URLQueryItem(name: "timezone", value: TimeZone.current.identifier)
        ]
    }
}
