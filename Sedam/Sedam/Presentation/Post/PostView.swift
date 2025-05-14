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
                    .font(.danjoBold24)
                LogoView(size: 10)
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
                Spacer()
                    .frame(height: 20)
                ScrollView {
                    Text(post?.content ?? "")
                        .font(.danjoBold14)
                        .padding(.horizontal, 20)
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
        .onAppear {
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
