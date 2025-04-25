//
//  MainText.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct MainText: View {
    let title: String
    let fontType: Font
    let color: Color?
    
    init(
        _ title: String,
        fontType: Font,
        color: Color? = Color.black
    ) {
        self.title = title
        self.fontType = fontType
        self.color = color
    }
    
    var body: some View {
        Text(title)
            .font(fontType)
            .foregroundStyle(color ?? Color.black)
    }
}
