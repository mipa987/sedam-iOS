//
//  MyPostListCellView.swift
//  Sedam
//
//  Created by minsong kim on 5/9/25.
//

import SwiftUI

struct MyPostListCellView: View {
    @EnvironmentObject private var router: Router
    @Binding var post: PostDTO
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text(post.title)
                .font(.maruburiBold18)
                .padding(.bottom, 8)
            Text(dateFormatter.string(from: post.createdAtDate ?? .now))
                .font(.maruburiRegular14)
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

