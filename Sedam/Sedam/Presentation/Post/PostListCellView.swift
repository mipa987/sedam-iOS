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
    @Binding var post: PostDTO
    var index: Int

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH시\nmm분"
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text(post.title)
                .font(.danjoBold18)
            Text(post.userNickname)
                .font(.danjoBold14)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(alignment: .leading) {
            if viewModel.postListType.sort == .likes {
                RankComponent(rank: $rank)
                    .padding(.leading, 16)
            } else {
                Text(dateFormatter.string(from: post.updatedAtDate ?? .now))
                    .font(.danjoBold18)
                    .padding(.leading, 16)
            }
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
            router.push(.postDetail(postId: post.id))
        }
    }
}

//#Preview {
//    PostListCellView(rank: "1", title: "this world", user: "mint", likes: "123")
//        .environmentObject(PostViewModel())
//}
