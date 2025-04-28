//
//  PostView.swift
//  Sedam
//
//  Created by minsong kim on 4/28/25.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var viewModel: PostViewModel
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                LogoView(size: 10)
                Text("주제 3가지")
                    .font(.danjoBold14)
                Text(viewModel.selectedPost?.title ?? "")
                    .font(.danjoBold24)
                LogoView(size: 10)
                Spacer()
                    .frame(height: 20)
                ScrollView {
                    Text(viewModel.selectedPost?.content ?? "")
                    .font(.danjoBold14)
                    .padding(.horizontal, 20)
                }
            }
        }
    }
}

#Preview {
    PostView()
        .environmentObject(PostViewModel())
}
