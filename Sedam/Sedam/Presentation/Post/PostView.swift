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
    
    var post: Post
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                Spacer()
                LogoView(size: 10)
                Text("주제 3가지")
                    .font(.danjoBold14)
                Text(post.title)
                    .font(.danjoBold24)
                LogoView(size: 10)
                Button {
                    viewModel.deletePost(id: post.id)
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
                    Text(post.content)
                        .font(.danjoBold14)
                        .padding(.horizontal, 20)
                }
                LikeButton(color: .tranquility, count: post.likes)
            }
        }
    }
}

#Preview {
    PostView(post: Post(id: UUID(), userId: UUID(), title: "title", content: "content", likes: 12, createdAt: "12/3"))
        .environmentObject(PostViewModel())
}
