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
        case maruburiRegular
        case maruburiLight
        case maruburiSemiBold
        case maruburiBold
        
        var file: String {
            switch self {
            case .danjo:
                "Danjo-bold-Regular"
            case .pretendard:
                "Pretendard-SemiBold"
            case .maruburiRegular:
                "MaruBuriot-Regular"
            case .maruburiLight:
                "MaruBuriot-Light"
            case .maruburiSemiBold:
                "MaruBuriot-SemiBold"
            case .maruburiBold:
                "MaruBuriot-Bold"
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
    static let danjoBold24: Font = .custom(SFont.Name.danjo.file, size: 24)
    static let danjoBold18: Font = .custom(SFont.Name.danjo.file, size: 18)
    static let danjoBold14: Font = .custom(SFont.Name.danjo.file, size: 14)
    
    //pretendard
    static let pretendardSemiBold14: Font = .custom(SFont.Name.pretendard.file, size: 14)
    static let pretendardSemiBold18: Font = .custom(SFont.Name.pretendard.file, size: 18)
    
    //maruBuri
    static let maruburiRegular14: Font = .custom(SFont.Name.maruburiRegular.file, size: 14)
    static let maruburiRegular18: Font = .custom(SFont.Name.maruburiRegular.file, size: 18)
    static let maruburiRegular24: Font = .custom(SFont.Name.maruburiRegular.file, size: 24)
    
    static let maruburiSemibold14: Font = .custom(SFont.Name.maruburiSemiBold.file, size: 14)
    
    static let maruburiBold18: Font = .custom(SFont.Name.maruburiBold.file, size: 18)
    static let maruburiBold24: Font = .custom(SFont.Name.maruburiBold.file, size: 24)
    static let maruburiBold32: Font = .custom(SFont.Name.maruburiBold.file, size: 32)
}
