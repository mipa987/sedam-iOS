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
    @StateObject private var userViewModel: UserViewModel = UserViewModel()
    
    var body: some View {
        RouterView {
            TabContainerView()
                .fullScreenCover(
                    isPresented: $authViewModel.isLogInPresented,
                    onDismiss: {}
                ) {
                    LoginView()
                }
                .fullScreenCover(
                    isPresented: $authViewModel.isTermPresented,
                    onDismiss: {}
                ) {
                    TermView(isButtonEnabled: true)
                }
        }
        .environmentObject(postViewModel)
        .environmentObject(authViewModel)
        .environmentObject(userViewModel)
    }
}
