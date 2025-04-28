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
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                LogoView(size: 10)
                Text("바람, 강아지, 수건")
                    .font(.danjoBold18)
                LogoView(size: 10)
                VStack {
                    TextField("제목을 입력하세요.", text: $title)
                        .font(.danjoBold24)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 4)
                    ZStack(alignment: .topLeading) {
                        if content.isEmpty {
                            Text("3가지 단어가 모두 들어간 글을 작성해주세요.")
                                .foregroundStyle(.gray)
                                .font(.danjoBold14)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 28)
                        }
                        TextEditor(text: $content)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 24)
                            .multilineTextAlignment(.leading)
                            .font(.danjoBold14)
                            .lineSpacing(4)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                    }
                }.overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.dadsCoupe, lineWidth: 2)
                        .padding(.horizontal, 24)
                )
                MainButton(title: "등록", font: .pretendardSemiBold18, color: .dadsCoupe)
                    .padding(.horizontal, 24)
                    .onTapGesture {
                        viewModel.createNewPost(title: title, content: content)
                    }
            }
            Spacer()
        }
    }
}

#Preview {
    PostCreateView(title: "",content: "")
}
