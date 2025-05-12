//
//  AllTermsBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct AllTermsBuilder: BuilderProtocol {
    typealias Response = String
    
    var baseURL: BaseURLType { .production }
    var path: String = "/today-words/today"
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .get }
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())
    
    var useAuthorization: Bool { false }
}
