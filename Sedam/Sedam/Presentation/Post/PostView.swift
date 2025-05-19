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
    
    @State var post: PostDTO?
    @State var isLiked: Bool = false
    var isMyPost: Bool = true
    var postId: String
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                LogoView(size: 10)
                Text(post?.todayWords.joined(separator: ", ") ?? "")
                    .font(.danjoBold14)
                Text(post?.title ?? "")
                    .font(.maruburiRegular24)
                    .padding(.vertical, 8)
                LogoView(size: 10)
                if isMyPost {
                    HStack {
                        Button {
                            Task { @MainActor in
                                do {
                                    try await viewModel.deletePost(id: postId)
                                    router.pop()
                                } catch {
                                    print("❌ error: \(error.localizedDescription)")
                                }
                            }
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundStyle(.black)
                        }
                        Button {
                            print("update post")
                            router.push(.updatePost(id: postId, title: post?.title ?? "", content: post?.content ?? ""))
                        } label: {
                            Image(systemName: "pencil.line")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15)
                                .foregroundStyle(.black)
                        }
                    }
                }
                Spacer()
                    .frame(height: 20)
                ScrollView {
                    Text(post?.content ?? "")
                        .font(.maruburiRegular14)
                        .lineSpacing(12)
                }
                LikeButton(isTapped: $isLiked, count: post?.likes ?? 0, color: .tranquility)
                    .tap {
                        Task {
                            try await viewModel.tapLike(id: postId, isLiked: isLiked)
                            if isLiked {
                                self.isLiked = false
                            } else {
                                self.isLiked = true
                            }
                            self.post = try await viewModel.fetchPostDetail(id: postId)
                        }
                    }
            }
        }
        .task {
            // TODO: - 포스트의 유저 id가 내 id와 동일한지 확인
//            if post?.userID ==
            Task { @MainActor in
                self.post = try await viewModel.fetchPostDetail(id: postId)
                self.isLiked = try await viewModel.isLiked(id: postId)
            }
        }
    }
}

//#Preview {
//    PostView(post: Post(id: UUID(), userId: UUID(), title: "title", content: "content", likes: 12, createdAt: "12/3"))
//        .environmentObject(PostViewModel())
//}
