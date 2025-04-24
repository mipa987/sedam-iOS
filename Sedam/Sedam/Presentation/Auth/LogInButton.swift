//
//  LogInButton.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import SwiftUI

enum LogIn: String, CaseIterable {
    case kakao
    case apple
    
    var backgroundColor: Color {
        switch self {
        case .kakao:
            return Color.kakao
        case .apple:
            return Color.black
        }
    }
    
    var titleColor: Color {
        switch self {
        case .kakao:
            return Color.black
        case .apple:
            return Color.white
        }
    }
    
    var title: String {
        switch self {
        case .kakao:
            "카카오 ID로 로그인"
        case .apple:
            "Apple ID로 로그인"
        }
    }
    
    var type: String {
        switch self {
        case .kakao:
            "KAKAO"
        case .apple:
            "APPLE"
        }
    }
    
    var image: Image {
        switch self {
        case .kakao:
            Image(.kakao)
        case .apple:
            Image(.apple)
        }
    }
}

struct LoginButton: View {
    let type: LogIn
    
    init(type: LogIn) {
        self.type = type
    }
    
    var body: some View {
        MainText(type.title, fontType: .pretendardSemiBold14, color: type.titleColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(type.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(alignment: .leading) {
                type.image
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 16)
            }
    }
}


#Preview {
    LoginButton(type: .apple)
}

public struct MainText: View {
    let title: String
    let fontType: Font
    let color: Color?

    public init(
        _ title: String,
        fontType: Font,
        color: Color? = Color.black
    ) {
        self.title = title
        self.fontType = fontType
        self.color = color
    }

    public var body: some View {
        Text(title)
            .font(fontType)
            .foregroundStyle(color ?? Color.black)
    }
}
