//
//  MainButton.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct MainButton: View {
    var title: String
    var isEnable: Bool = true
    var height: CGFloat = 52
    var action: (() -> Void)?
    var font: Font
    var color: Color
    
    public init(title: String, font: Font, color: Color) {
        self.title = title
        self.font = font
        self.color = color
    }
    
    public var body: some View {
        Text(title)
            .font(font)
            .foregroundStyle(isEnable ? Color.white : color)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(isEnable ? color : Color.white)
            )
            .onTapGesture {
                guard isEnable else { return }
                action?()
            }
    }
}

extension MainButton {
    func enable(_ isEnable: Bool) -> Self {
        var copy = self
        copy.isEnable = isEnable
        return copy
    }
    
    func height(_ height: CGFloat) -> Self {
        var copy = self
        copy.height = height
        return copy
    }
    
    func tap(action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

