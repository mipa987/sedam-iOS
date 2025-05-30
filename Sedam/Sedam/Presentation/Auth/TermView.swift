//
//  TermView.swift
//  세담
//
//  Created by minsong kim on 5/2/25.
//

import SwiftUI

struct TermView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var isButtonEnabled: Bool = false
    
    var body: some View {
        VStack {
            WKWebViewPresentation(url: "https://marchens.notion.site/sedam-term?pvs=4")
        }
        .overlay(alignment: .bottom) {
            if isButtonEnabled {
                MainButton(title: "동의", font: .pretendardSemiBold18, color: .dadsCoupe)
                    .tap {
                        viewModel.agreeTerms(to: .privacyPolicy)
                    }
                    .padding(.horizontal, 24)
            }
        }
    }
}

#Preview {
    TermView()
}
