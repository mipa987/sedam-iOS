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
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var post: PostDTO?
    @State var isLiked: Bool = false
    @State var isMyPost: Bool = false
    @State var showLogInPopUp: Bool = false
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
                        .padding(.horizontal, 20)
                }
                LikeButton(isTapped: $isLiked, count: post?.likes ?? 0, color: .tranquility)
                    .tap {
                        Task {
                            do {
                                try await viewModel.tapLike(id: postId, isLiked: isLiked)
                                if isLiked {
                                    self.isLiked = false
                                } else {
                                    self.isLiked = true
                                }
                                self.post = try await viewModel.fetchPostDetail(id: postId)
                            } catch NetworkError.accessDenied {
                                withAnimation {
                                    showLogInPopUp = true
                                }
                            }
                        }
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
        .overlay {
            if showLogInPopUp {
                CustomPopUpView(
                    showPopUp: $showLogInPopUp,
                    title: "로그인",
                    message: "로그인이 필요한 서비스입니다.\n\n로그인 하시겠습니까?",
                    leftButtonText: "취소",
                    rightButtonText: "확인",
                    leftButtonAction: { withAnimation { showLogInPopUp = false }},
                    rightButtonAction: {
                        authViewModel.authenticationState = .splash
                        showLogInPopUp = false
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
