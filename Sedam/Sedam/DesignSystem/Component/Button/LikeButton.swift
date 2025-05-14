//
//  LikeButton.swift
//  Sedam
//
//  Created by minsong kim on 4/28/25.
//

import SwiftUI

struct LikeButton: View {
    @Binding var isTapped: Bool
    var count: Int
    var action: (() -> Void)?
    var color: Color
    
    public var body: some View {
        HStack {
            Image(isTapped ? .heartBubble : .squareBubble)
                .renderingMode(.template)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(isTapped ? Color.dadsCoupe : color)
            Text("추천해요 \(count)")
                .font(.danjoBold14)
                .foregroundStyle(isTapped ? Color.dadsCoupe : color)
        }
        .frame(width: 110, height: 42)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(isTapped ? color : Color.white)
        )
        .onTapGesture {
            action?()
        }
    }
}

extension LikeButton {
    func tap(action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}
