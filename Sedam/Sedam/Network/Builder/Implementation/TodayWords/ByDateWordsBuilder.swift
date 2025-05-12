//
//  ByDateWordsBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct ByDateWordsBuilder: BuilderProtocol {
    typealias Response = [String]
    
    var baseURL: BaseURLType { .production }
    var path: String = "/today-words/by-date"
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .get }
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())
    
    var useAuthorization: Bool { false }
}
