//
//  AllTermsBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct AllTermsBuilder: BuilderProtocol {
    typealias Response = ResponseDTO
    
    var baseURL: BaseURLType { .qa }
    var path: String = PathURLType.terms.path(type: .qa)
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .get }
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())
    
    var useAuthorization: Bool { false }
}
