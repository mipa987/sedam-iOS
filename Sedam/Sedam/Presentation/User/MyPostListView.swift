//
//  MyPostListView.swift
//  Sedam
//
//  Created by minsong kim on 5/9/25.
//

import SwiftUI

struct MyPostListView: View {
//    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: PostViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var showLogInPopUp: Bool = false
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            ScrollView {
                ForEach($viewModel.myPostList.indices, id: \.self) { index in
                    MyPostListCellView(
                        post: $viewModel.myPostList[index]
                    )
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 160) // 아래 여유 주기
            }
            Spacer()
        }
        .onAppear {
            showLogInPopUp = false
            Task { @MainActor in
                do {
                    try await viewModel.fetchMyPostList()
                } catch NetworkError.accessDenied {
                    withAnimation {
                        showLogInPopUp = true
                    }
                } catch {
                    print("❌ error : \(error.localizedDescription)")
                }
            }
        }
        .overlay {
            if showLogInPopUp {
                CustomPopUpView(
                    showPopUp: $showLogInPopUp,
                    title: "로그인",
                    message: "로그인이 필요한 서비스입니다.\n\n로그인 하시겠습니까?",
                    leftButtonText: "취소",
                    rightButtonText: "확인",
                    leftButtonAction: { withAnimation { showLogInPopUp = false }},
                    rightButtonAction: {
                        authViewModel.authenticationState = .splash
                        showLogInPopUp = false
                    }
                )
            }
        }
    }
}
