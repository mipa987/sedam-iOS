//
//  Router.swift
//  Sedam
//
//  Created by minsong kim on 4/27/25.
//

import SwiftUI

final class Router: ObservableObject {
    enum Route: Hashable {
        case authLogin
//        case main
        case createPost
        case postDetail(post: Post)
    }

    @Published var path = NavigationPath()
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .authLogin:
            LoginView()
//        case .main:
//            MainView()
        case .createPost:
            PostCreateView()
        case .postDetail(let post):
            PostView(post: post)
        }
    }
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
