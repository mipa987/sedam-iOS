//
//  PostCreateView.swift
//  Sedam
//
//  Created by minsong kim on 4/28/25.
//

import SwiftUI

struct PostCreateView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: PostViewModel
    
    @State var title: String = ""
    @State var content: String = ""
    @FocusState private var isTextEditorFocused: Bool
    
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
                Text(viewModel.todayWords.joined(separator: ", "))
                    .font(.maruburiSemibold14)
                TextField("제목을 입력하세요.", text: $title)
                    .font(.maruburiBold24)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                VStack {
                    ZStack(alignment: .topLeading) {
                        if content.isEmpty {
                            Text("3가지 단어가 모두 들어간 글을 작성해주세요.")
                                .foregroundStyle(.gray)
                                .font(.maruburiRegular14)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 28)
                        }
                        TextEditor(text: $content)
                            .focused($isTextEditorFocused)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.horizontal, 24)
                            .multilineTextAlignment(.leading)
                            .font(.maruburiRegular14)
                            .lineSpacing(12)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.dadsCoupe, lineWidth: 2)
                        .padding(.horizontal, 24)
                )
                MainButton(title: "등록", font: .pretendardSemiBold18, color: .dadsCoupe)
                    .tap() {
                        viewModel.createNewPost(title: title, content: content)
                    }
                    .padding(.horizontal, 24)
            }
            Spacer()
        }
        .onReceive(viewModel.postCreatedPublisher) { _ in
            router.pop()
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
        }
    }
}

//#Preview {
//    PostCreateView(title: "",content: "")
//        .environmentObject(PostViewModel())
//}
