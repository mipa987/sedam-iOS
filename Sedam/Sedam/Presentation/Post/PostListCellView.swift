//
//  PostListCellView.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct PostListCellView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: PostViewModel
    @State var rank: String
    let post: Post
    
    var body: some View {
        VStack {
            Text(post.title)
                .font(.danjoBold18)
            Text(post.userId.uuidString)
                .font(.danjoBold14)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(alignment: .leading) {
            RankComponent(rank: $rank)
                .padding(.leading, 16)
        }
        .overlay(alignment: .trailing) {
            VStack {
                Image(.heartBubble)
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(post.likes.rawValue)
                    .font(.danjoBold14)
            }
            .padding(.trailing, 16)
        }
        .onTapGesture {
            router.push(.postDetail(post: post))
        }
    }
}

//#Preview {
//    PostListCellView(rank: "1", title: "this world", user: "mint", likes: "123")
//        .environmentObject(PostViewModel())
//}
