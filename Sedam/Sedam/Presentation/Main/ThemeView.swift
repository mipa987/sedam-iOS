//
//  ThemeView.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct ThemeView: View {
    @EnvironmentObject var wordViewModel: WordViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            Text("오늘의 3단어")
                .font(.danjoBold14)
            Text(wordViewModel.words.joined(separator: ", "))
                .font(.danjoBold18)
        }
        .foregroundStyle(.black)
        .task {
            wordViewModel.getTodayWords()
        }
    }
}

#Preview {
    ThemeView()
}
