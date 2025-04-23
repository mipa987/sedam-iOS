//
//  BaseURLRegistrable.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import Foundation

public protocol BaseURLRegistrable {
    func register(_ url: URL, for type: BaseURLType)
}
