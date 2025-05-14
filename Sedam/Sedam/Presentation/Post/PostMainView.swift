//
//  MainView.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct PostMainView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject var viewModel: PostViewModel
    
    private var indexedPosts: [(offset: Int, element: PostDTO)] {
        Array(viewModel.postList.enumerated())
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // 1) 배경만 화면 전체 + safe area 무시
                Color.modernIvory
                    .ignoresSafeArea()
                
                // 2) 화면 전체 크기를 차지시키되, 내용은 위쪽 정렬
                VStack(spacing: 16) {
                    // 3) safe area 높이만큼 패딩
                    LogoView(size: 20)
                    ThemeView()
                    LogoView(size: 20)
                    
                    // 4) 남은 공간은 스크롤뷰로 채움
                    ScrollView {
                        ForEach($viewModel.postList.indices, id: \.self) { index in
                            PostListCellView(
                                rank: String(index + 1),
                                post: $viewModel.postList[index],
                                index: index
                            )
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 160) // 아래 여유 주기
                    }
                    Spacer()
                }
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height,
                    alignment: .top     // VStack 전체를 위쪽 정렬
                )
                .padding(.top, proxy.safeAreaInsets.top + 48)
                .task {
                    viewModel.fetchPostList(sortBy: .likes, order: .desc)
                }
            }
        }
    }
}

#Preview {
    PostMainView()
        .environmentObject(PostViewModel())
}
