//
//  PostUpdateView.swift
//  Sedam
//
//  Created by minsong kim on 5/16/25.
//

import SwiftUI

struct PostUpdateView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: PostViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var title: String
    @State var content: String
    @State var showLogInPopUp: Bool = false
    @FocusState private var isTextEditorFocused: Bool
    var postId: String
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
                .onTapGesture {
                    // 2) 배경 터치 시 포커스 해제
                    isTextEditorFocused = false
                }
            
            VStack(alignment: .center) {
                LogoView(size: 10)
                Text(viewModel.detailPost?.todayWords.joined(separator: ", ") ?? "")
                    .font(.danjoBold14)
                TextField(title, text: $title)
                    .font(.maruburiRegular24)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                VStack {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $content)
                            .focused($isTextEditorFocused)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 24)
                            .multilineTextAlignment(.leading)
                            .font(.maruburiRegular14)
                            .lineSpacing(12)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                    }
                }.overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.dadsCoupe, lineWidth: 2)
                        .padding(.horizontal, 24)
                )
                MainButton(title: "등록", font: .pretendardSemiBold18, color: .dadsCoupe)
                    .tap() {
                        viewModel.updatePost(title: title, content: content, id: postId)
                    }
                    .padding(.horizontal, 24)
            }
            Spacer()
        }
        .task {
            Task { @MainActor in
                try await viewModel.fetchPostDetail(id: postId)
            }
        }
        .onReceive(viewModel.postUpdatedPublisher) { _ in
            router.pop()
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare() 
            generator.impactOccurred()
        }
    }
}
