//
//  CardView.swift
//  Sedam
//
//  Created by minsong kim on 5/29/25.
//

import SwiftUI

struct CardView: View {
    var title: String
    var content: String
    var words: String
    @Binding var colors: Color
    @Binding var fontColors: Color
    @Binding var isThreeWords: Bool
    
    var body: some View {
        ZStack {
            colors
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                if isThreeWords {
                    Text(words)
                        .font(.maruburiRegular10)
                }
                Text(title)
                    .font(.maruburiBold18)
                    .multilineTextAlignment(.center)
                Text(content)
                    .font(.maruburiRegular14)
                    .multilineTextAlignment(.center)
                    .lineSpacing(16)
            }
            .foregroundStyle(fontColors)
        }
    }
}
