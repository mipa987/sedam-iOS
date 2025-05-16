//
//  Router.swift
//  Sedam
//
//  Created by minsong kim on 4/27/25.
//

import SwiftUI

final class Router: ObservableObject {
    enum Route: Hashable {
        case personalTerm
        case createPost
        case updatePost(id: String, title: String, content: String)
        case postDetail(postId: String)
        case myPostList
    }

    @Published var path = NavigationPath()
    
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
