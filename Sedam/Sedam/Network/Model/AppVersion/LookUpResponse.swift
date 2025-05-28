//
//  LookUpResponse.swift
//  Sedam
//
//  Created by minsong kim on 5/28/25.
//

import Foundation

struct LookupResponse: Decodable {
    let results: [AppInfo]
}
