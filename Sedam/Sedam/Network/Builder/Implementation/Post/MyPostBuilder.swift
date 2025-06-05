//
//  MyPostBuilder.swift
//  Sedam
//
//  Created by minsong kim on 5/13/25.
//

import Foundation

struct MyPostBuilder: BuilderProtocol {
    typealias Response = [PostDTO]
    
    var path: String = PathURLType.myPost.path()
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .get }
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())
    
    var useAuthorization: Bool { true }
    
    init(sort: String, order: String, startDate: String?, endDate: String?) {
        self.queries =
        [
            URLQueryItem(name: "sort_by", value: sort),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "start_date", value: startDate),
            URLQueryItem(name: "end_date", value: endDate)
        ]
    }
}
