//
//  NicknameBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct NicknameBuilder: BuilderProtocol {
    typealias Response = UserDTO
    
    var baseURL: BaseURLType { .production }
    var path: String = PathURLType.userNickname.path(type: .qa)
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod 
    let parameters: [String: Any]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { true }
    
    init(http: HTTPMethod, parameters: [String: Any] = [:]) {
        method = http
        self.parameters = parameters
    }
}
