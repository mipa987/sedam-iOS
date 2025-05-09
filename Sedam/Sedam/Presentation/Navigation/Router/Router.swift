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
        case personalTerm
        case createPost
        case postDetail(post: Int)
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
