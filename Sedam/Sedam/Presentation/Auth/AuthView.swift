//
//  AuthView.swift
//  Sedam
//
//  Created by minsong kim on 4/29/25.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var authViewModel: AuthViewModel
    @StateObject private var postViewModel = PostViewModel()
    
    var body: some View {
        if authViewModel.authenticationState == .signIn {
            RouterView {
                TabContainerView()
            }
            .environmentObject(postViewModel)
        } else {
            LoginView()
        }
    }
}
