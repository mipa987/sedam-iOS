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
        case pretendard
        
        var file: String {
            switch self {
            case .danjo:
                "Danjo-bold-Regular"
            case .pretendard:
                "Pretendard-SemiBold"
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
    //danjo
    static let danjoBold60: Font = .custom(SFont.Name.danjo.file, size: 60)
    static let danjoBold48: Font = .custom(SFont.Name.danjo.file, size: 48)
    static let danjoBold32: Font = .custom(SFont.Name.danjo.file, size: 32)
    static let danjoBold18: Font = .custom(SFont.Name.danjo.file, size: 18)
    static let danjoBold14: Font = .custom(SFont.Name.danjo.file, size: 14)
    
    //pretendard
    static let pretendardSemiBold14: Font = .custom(SFont.Name.pretendard.file, size: 14)
}
