//
//  SFont.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import SwiftUI

enum SFont {
    enum Name {
        case danjo
        
        var file: String {
            switch self {
            case .danjo:
                "Danjo-bold-Regular"
            }
        }
    }
    
    enum Size: CGFloat {
        case _13 = 13
        case _14 = 14
        case _15 = 15
        case _17 = 17
        case _22 = 22
        case _24 = 24
        case _28 = 28
        case _32 = 32
    }
}

extension Font {
    static let danjoBold32: Font = .custom(SFont.Name.danjo.file, size: 32)
    static let danjoBold14: Font = .custom(SFont.Name.danjo.file, size: 14)
}
