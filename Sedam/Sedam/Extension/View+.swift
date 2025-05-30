//
//  View+.swift
//  Sedam
//
//  Created by minsong kim on 5/29/25.
//

import SwiftUI

extension View {
    //뷰를 동적 크기로 렌더링하고 padding만큼 여백을 붙여 UIImage로 반환
    func renderedImage(withPadding padding: CGFloat = 20, backgroundColor: Color) -> UIImage {
        let view = self
            .padding(padding)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        
        // ImageRenderer 이용
        let renderer = ImageRenderer(content: view)
        renderer.scale = UIScreen.main.scale
        renderer.proposedSize = .unspecified
        return renderer.uiImage!
    }
}
