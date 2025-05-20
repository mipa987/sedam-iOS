//
//  LaunchView.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            VStack {
                LogoView(isVertical: true, size: 30)
                    .padding(.vertical, 32)
                Text(
                """
                세담은 일본 전통의 ‘三題噺(산다이바나시)’에서 영감을 받아 탄생했어요.
                3가지 단어를 모두 사용해서 하나의 이야기를 만들어 보세요.
                """
                )
                .font(.maruburiRegular10)
                .lineSpacing(12)
                .multilineTextAlignment(.center)
            }
            .padding()
        }
    }
}

#Preview {
    LaunchView()
}
