//
//  DeleteUserBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct DeleteUserBuilder: BuilderProtocol {
    typealias Response = ResponseDTO
    
    var baseURL: BaseURLType { .production }
    var path: String = PathURLType.userDelete.path(type: .qa)
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .delete }
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { true }
}
