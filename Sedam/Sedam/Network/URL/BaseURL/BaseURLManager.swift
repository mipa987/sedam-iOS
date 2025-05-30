//
//  BaseURLManager.swift
//  Sedam
//
//  Created by minsong kim on 5/26/25.
//

import Foundation

//개발 서버와 라이브 서버를 교체할 수 있도록 (QA용)
class BaseURLManager: BaseURLResolvable, BaseURLRegistrable {
    var baseURLMap: [BaseURLType: URL] = [:]
    
    init(baseURLMap: [BaseURLType : URL] = [:]) {
        self.baseURLMap = baseURLMap
    }

    func resolve(for type: BaseURLType) -> URL? {
        baseURLMap[type]
    }

    func register(_ url: URL, for type: BaseURLType) {
        baseURLMap[type] = url
    }
}
