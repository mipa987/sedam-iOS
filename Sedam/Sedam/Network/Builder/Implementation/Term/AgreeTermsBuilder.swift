//
//  AgreeTermsBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct AgreeTermsBuilder: BuilderProtocol {
    typealias Response = ResponseDTO
    
    var baseURL: BaseURLType { .production }
    var path: String = PathURLType.terms.path(type: .qa)
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())
    
    var useAuthorization: Bool { true }
    
    init(termTitle: String, httpMethod: HTTPMethod) {
        path += "/\(termTitle)/agree"
        method = httpMethod
    }
}
