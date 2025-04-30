//
//  RouterView.swift
//  Sedam
//
//  Created by minsong kim on 4/27/25.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    private let content: Content
    
    init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                content
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .navigationDestination(for: Router.Route.self) { route in
                router.view(for: route)
            }
        }
        .environmentObject(router)
    }
}

