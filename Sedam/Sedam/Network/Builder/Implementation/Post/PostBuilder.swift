//
//  PostBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

struct PostBuilder: BuilderProtocol {
    typealias Response = [PostDTO]
    
    var baseURL: BaseURLType { .production }
    var path: String = "/posts"
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod
    let parameters: [String: Any]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())
    
    var useAuthorization: Bool
    
    init(httpMethod: HTTPMethod = .get, sort: String, order: String, startDate: String?, endDate: String?) {
        method = httpMethod
        parameters = [:]
        useAuthorization = false
        self.queries =
        [
            URLQueryItem(name: "sort_by", value: sort),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate)
        ]
    }
    
    init (httpMethod: HTTPMethod = .post, parameters: [String: Any]) {
        method = httpMethod
        self.parameters = parameters
        useAuthorization = true
    }
}
