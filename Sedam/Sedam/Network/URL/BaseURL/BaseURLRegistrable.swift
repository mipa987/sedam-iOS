//
//  BaseURLRegistrable.swift
//  Sedam
//
//  Created by minsong kim on 5/26/25.
//

import Foundation

protocol BaseURLRegistrable {
    func register(_ url: URL, for type: BaseURLType)
}
