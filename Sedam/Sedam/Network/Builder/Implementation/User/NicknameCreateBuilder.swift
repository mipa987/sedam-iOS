//
//  NicknameCreateBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/19/25.
//

import Foundation

struct NicknameCreateBuilder: BuilderProtocol {
    typealias Response = ResponseDTO
    
    var path: String = PathURLType.userNicknameCreate.path()
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod = .post
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { true }
}
