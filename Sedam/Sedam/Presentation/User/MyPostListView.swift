//
//  MyPostListView.swift
//  Sedam
//
//  Created by minsong kim on 5/9/25.
//

import SwiftUI

struct MyPostListView: View {
    @EnvironmentObject var viewModel: PostViewModel
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            ScrollView {
                ForEach($viewModel.myPostList.indices, id: \.self) { index in
                    MyPostListCellView(
                        post: $viewModel.myPostList[index]
                    )
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 160) // 아래 여유 주기
            }
            Spacer()
        }
        .task {
            viewModel.fetchMyPostList()
        }
    }
}
