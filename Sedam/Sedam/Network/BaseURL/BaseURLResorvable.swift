//
//  BaseURLResorvable.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import Foundation

public protocol BaseURLResolvable {
    func resolve(for type: BaseURLType) -> URL?
}
