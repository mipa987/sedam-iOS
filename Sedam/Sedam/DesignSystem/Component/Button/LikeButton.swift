//
//  LikeButton.swift
//  Sedam
//
//  Created by minsong kim on 4/28/25.
//

import SwiftUI

struct LikeButton: View {
    var isEnable: Bool = true
    var action: (() -> Void)?
    var color: Color
    var count: String
    
    public init(color: Color, count: Int) {
        self.color = color
        self.count = String(count)
    }
    
    public var body: some View {
        HStack {
            Image(.heartBubble)
                .renderingMode(.template)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(isEnable ? Color.white : color)
            Text("좋아요 \(count)")
                .font(.danjoBold14)
                .foregroundStyle(isEnable ? Color.white : color)
        }
        .frame(width: 110, height: 42)
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

extension LikeButton {
    func enable(_ isEnable: Bool) -> Self {
        var copy = self
        copy.isEnable = isEnable
        return copy
    }
    
    func tap(action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}

