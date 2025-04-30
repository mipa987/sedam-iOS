//
//  ThemeView.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct ThemeView: View {
    var themes: [String] = ["바람", "강아지", "물티슈"]
    
    var body: some View {
        VStack(spacing: 8) {
            Text("오늘의 3단어")
                .font(.danjoBold14)
            Text(themes.joined(separator: ", "))
                .font(.danjoBold18)
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    ThemeView()
}
