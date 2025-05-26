//
//  AuthenticatedView.swift
//  세담
//
//  Created by minsong kim on 5/2/25.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
    @StateObject var postViewModel: PostViewModel = PostViewModel()
    @StateObject var userViewModel: UserViewModel = UserViewModel()
    
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
        .onOpenURL { url in
            Task {
                // Apple/Kakao 로그인 콜백을 세션으로 변환
                try? await SupabaseManager.shared.supabase.auth.session(from: url)
            }
        }
        .overlay {
            if authViewModel.showLogInPopUp {
                CustomPopUpView(
                    showPopUp: $authViewModel.showLogInPopUp,
                    title: "로그인",
                    message: "로그인이 필요한 서비스입니다.\n\n로그인 하시겠습니까?",
                    leftButtonText: "취소",
                    rightButtonText: "확인",
                    leftButtonAction: { withAnimation { authViewModel.showLogInPopUp = false }},
                    rightButtonAction: {
                        authViewModel.authenticationState = .splash
                        authViewModel.showLogInPopUp = false
                    }
                )
            }
        }
    }
}
