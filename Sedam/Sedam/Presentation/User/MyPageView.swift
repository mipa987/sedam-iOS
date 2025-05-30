//
//  MyPageView.swift
//  세담
//
//  Created by minsong kim on 5/7/25.
//

import SwiftUI

struct MyPageView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var viewModel: UserViewModel
    @State var showSignOutPopUp: Bool = false
    @State var showLogOutPopUp: Bool = false
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            VStack {
                UserCardView(name: $viewModel.name)
                    .padding(.horizontal, 16)
                    .frame(height: 100)
                SettingCardView(showSignOutPopUp: $showSignOutPopUp, showLogOutPopUp: $showLogOutPopUp)
                    .padding(.horizontal, 16)
            }
        }
        .overlay {
            if showSignOutPopUp {
                CustomPopUpView(
                    showPopUp: $showSignOutPopUp,
                    title: "회원 탈퇴",
                    message: "탈퇴 시 작성하신 모든 글들이 삭제됩니다.\n\n정말 탈퇴하시겠습니까?",
                    leftButtonText: "취소",
                    rightButtonText: "확인",
                    leftButtonAction: { withAnimation { showSignOutPopUp = false } },
                    rightButtonAction: {
                        authViewModel.signOut()
                        showSignOutPopUp = false
                    }
                )
            }
            
            if showLogOutPopUp {
                CustomPopUpView(
                    showPopUp: $showLogOutPopUp,
                    title: "로그아웃",
                    message: "로그아웃 하시겠습니까?",
                    leftButtonText: "취소",
                    rightButtonText: "확인",
                    leftButtonAction: { withAnimation { showLogOutPopUp = false } },
                    rightButtonAction: {
                        authViewModel.logOut()
                        showLogOutPopUp = false
                    }
                )
            }
        }
    }
}

//struct MyPageView_Previews: PreviewProvider {
//  static var previews: some View {
//    MyPageView()
//  }
//}
