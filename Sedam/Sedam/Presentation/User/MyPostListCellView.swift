//
//  MyPostListCellView.swift
//  Sedam
//
//  Created by minsong kim on 5/9/25.
//

import SwiftUI

struct MyPostListCellView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var viewModel: PostViewModel
    @Binding var post: PostDTO
    
    var body: some View {
        VStack {
            Text(post.title)
                .font(.danjoBold18)
            Text(post.createdAt)
                .font(.danjoBold14)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
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

