//
//  RouterView.swift
//  Sedam
//
//  Created by minsong kim on 4/27/25.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    @EnvironmentObject var postViewModel: PostViewModel
    
    private let content: Content
    
    init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.Route.self) { route in
                    switch route {
                    case .authLogin:
                        LoginView()
                    case .personalTerm:
                        TermView()
                    case .createPost:
                        PostCreateView()
                    case .updatePost(let id, let title, let content):
                        PostUpdateView(title: title, content: content, postId: id)
                    case .postDetail(let id):
                        PostView(postId: id)
                    case .myPostList:
                        MyPostListView()
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarBackButtonHidden()
        }
        .tint(.black)
        .environmentObject(router)
    }
}

