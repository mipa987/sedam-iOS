//
//  PostView.swift
//  Sedam
//
//  Created by minsong kim on 4/28/25.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: PostViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var isLiked: Bool = false
    @State var isMyPost: Bool = false
    @State var showDeleteCheckPopUp: Bool = false
    var postId: String
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                LogoView(size: 10)
                Text(viewModel.detailPost?.todayWords.joined(separator: ", ") ?? "")
                    .font(.danjoBold14)
                Text(viewModel.detailPost?.title ?? "")
                    .font(.maruburiRegular24)
                    .padding(.vertical, 8)
                if isMyPost {
                    HStack(spacing: 12) {
                        Button {
                            withAnimation {
                                showDeleteCheckPopUp = true
                            }
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16)
                                .foregroundStyle(.black)
                        }
                        Button {
                            print("update post")
                            router.push(.updatePost(id: postId, title: viewModel.detailPost?.title ?? "", content: viewModel.detailPost?.content ?? ""))
                        } label: {
                            Image(systemName: "pencil.line")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16)
                                .foregroundStyle(.black)
                        }
                        
                        Button {
                            print("share post")
                            router.push(.sharePost(title: viewModel.detailPost?.title ?? "", content: viewModel.detailPost?.content ?? "", words: viewModel.detailPost?.todayWords.joined(separator: ", ") ?? ""))
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 14)
                                .foregroundStyle(.black)
                        }
                    }
                }
                Spacer()
                    .frame(height: 20)
                ScrollView {
                    Text(viewModel.detailPost?.content ?? "")
                        .font(.maruburiRegular14)
                        .lineSpacing(12)
                        .padding(.horizontal, 20)
                }
                LikeButton(isTapped: $viewModel.isLiked, count: viewModel.detailPost?.likes ?? 0, color: .tranquility)
                    .tap {
                        Task {
                            try await viewModel.toggleLike()
                        }
                    }
            }
        }
        .task {
            Task { @MainActor in
                try await viewModel.fetchPostDetail(id: postId)
                self.isLiked = try await viewModel.isLiked(id: postId)
                if viewModel.detailPost?.userNickname == userViewModel.name {
                    isMyPost = true
                }
            }
        }
        .onReceive(viewModel.postDeletedPublisher) { _ in
            router.pop()
        }
        .overlay {
            if showDeleteCheckPopUp {
                CustomPopUpView(
                    showPopUp: $showDeleteCheckPopUp,
                    title: "정말 삭제하시겠어요?",
                    message: "삭제하시면 되돌릴 수 없어요!\n\n정말 삭제하시겠어요?",
                    leftButtonText: "취소",
                    rightButtonText: "확인",
                    leftButtonAction: {
                        withAnimation {
                            showDeleteCheckPopUp = false
                        }
                    },
                    rightButtonAction: {
                        viewModel.deletePost(id: postId)
                        withAnimation {
                            showDeleteCheckPopUp = false
                        }
                    }
                )
            }
        }
    }
}

//#Preview {
//    PostView(post: Post(id: UUID(), userId: UUID(), title: "title", content: "content", likes: 12, createdAt: "12/3"))
//        .environmentObject(PostViewModel())
//}
