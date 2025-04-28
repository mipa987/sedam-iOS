//
//  LogoView.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct LogoView: View {
    var isVertical: Bool = false
    var size: CGFloat = 30
    
    var body: some View {
        if isVertical {
            VStack(spacing: 4) {
                Image(.heartBubble)
                    .resizable()
                    .frame(width: size, height: size)
                Image(.squareBubble)
                    .resizable()
                    .frame(width: size, height: size)
                Image(.roundBubble)
                    .resizable()
                    .frame(width: size, height: size)
            }
        } else {
            HStack(spacing: 4) {
                Image(.heartBubble)
                    .resizable()
                    .frame(width: size, height: size)
                Image(.squareBubble)
                    .resizable()
                    .frame(width: size, height: size)
                Image(.roundBubble)
                    .resizable()
                    .frame(width: size, height: size)
            }
        }
    }
}

#Preview {
    LogoView()
}
