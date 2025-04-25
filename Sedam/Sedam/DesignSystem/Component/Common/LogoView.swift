//
//  LogoView.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct LogoView: View {
    var isVertical: Bool = false
    
    var body: some View {
        if isVertical {
            VStack(spacing: 4) {
                Image(.heartBubble)
                    .resizable()
                    .frame(width: 30, height: 30)
                Image(.squareBubble)
                    .resizable()
                    .frame(width: 30, height: 30)
                Image(.roundBubble)
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        } else {
            HStack(spacing: 4) {
                Image(.heartBubble)
                    .resizable()
                    .frame(width: 30, height: 30)
                Image(.squareBubble)
                    .resizable()
                    .frame(width: 30, height: 30)
                Image(.roundBubble)
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
    }
}

#Preview {
    LogoView()
}
