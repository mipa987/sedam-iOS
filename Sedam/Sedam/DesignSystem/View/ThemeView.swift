//
//  ThemeView.swift
//  Sedam
//
//  Created by minsong kim on 5/21/25.
//

import SwiftUI

struct ThemeView: View {
    @Binding var date: Date
    @Binding var words: [String]
    var wordsFont: Font
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 8) {
            LogoView(size: 20)
            Text("\(dateFormatter.string(from: date))의 3단어")
                .font(.danjoBold14)
                .foregroundStyle(.gray)
            Text(words.joined(separator: ", "))
                .font(wordsFont)
        }
        .foregroundStyle(.black)
    }
}
