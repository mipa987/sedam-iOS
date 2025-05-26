//
//  BaseURLResolvable.swift
//  Sedam
//
//  Created by minsong kim on 5/26/25.
//

import Foundation

protocol BaseURLResolvable {
    func resolve(for type: BaseURLType) -> URL?
}
