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
    
    @State var post: PostDTO?
    @State var isLiked: Bool = false
    @State var isMyPost: Bool = false
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
                if isMyPost {
                    HStack {
                        Button {
                            viewModel.deletePost(id: postId)
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
                        .padding(.horizontal, 20)
                }
                LikeButton(isTapped: $isLiked, count: post?.likes ?? 0, color: .tranquility)
                    .tap {
                        viewModel.tapLike(id: postId, isLiked: isLiked)
                        //TODO: - 로직 수정 필요 (성공 시 toggle)
                        isLiked.toggle()
                    }
            }
        }
        .task {
            Task { @MainActor in
                self.post = try await viewModel.fetchPostDetail(id: postId)
                self.isLiked = try await viewModel.isLiked(id: postId)
                if post?.userNickname == userViewModel.name {
                    isMyPost = true
                }
            }
        }
        .onReceive(viewModel.postDeletedPublisher) { _ in
            router.pop()
        }
    }
}

//#Preview {
//    PostView(post: Post(id: UUID(), userId: UUID(), title: "title", content: "content", likes: 12, createdAt: "12/3"))
//        .environmentObject(PostViewModel())
//}
