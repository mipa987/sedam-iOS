//
//  AuthenticatedView.swift
//  세담
//
//  Created by minsong kim on 5/2/25.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    @StateObject private var postViewModel: PostViewModel = PostViewModel()
    @StateObject private var wordViewModel: WordViewModel = WordViewModel()
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .splash:
                LoginView()
            case .signIn:
                RouterView {
                    TabContainerView()
                }
                .environmentObject(postViewModel)
                .environmentObject(wordViewModel)
            case .term:
                TermView(isButtonEnabled: true)
            case .guest:
                RouterView {
                    TabContainerView()
                }
                .environmentObject(postViewModel)
            }
        }
        .environmentObject(authViewModel)
    }
}
