//
//  AuthenticatedView.swift
//  세담
//
//  Created by minsong kim on 5/2/25.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    @StateObject private var postViewModel: PostViewModel = PostViewModel()
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .splash:
                LoginView()
                    .environmentObject(authViewModel)
            case .signIn:
                RouterView {
                    TabContainerView()
                }
                .environmentObject(postViewModel)
            case .term:
                TermView()
                    .environmentObject(authViewModel)
            case .guest:
                RouterView {
                    TabContainerView()
                }
                .environmentObject(postViewModel)
            }
        }
    }
}
