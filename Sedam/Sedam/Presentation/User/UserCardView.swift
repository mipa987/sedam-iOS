//
//  UserCardView.swift
//  세담
//
//  Created by minsong kim on 5/7/25.
//

import SwiftUI

struct UserCardView: View {
    @EnvironmentObject var router: Router
    @Binding var name: String
    
    var body: some View {
        VStack {
            Button {
                //user nickname 변경
            } label: {
                Text(name)
                    .font(.danjoBold24)
                    .foregroundStyle(.white)
            }
            Divider()
            Button {
                router.push(.myPostList)
            } label: {
                Text("내 글 목록")
                    .font(.danjoBold18)
                    .foregroundStyle(.white)
            }
            
        }
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.juniperBerries)
        )
        .frame(maxWidth: .infinity)
    }
}
