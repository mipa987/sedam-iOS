//
//  SettingCardView.swift
//  Sedam
//
//  Created by minsong kim on 5/8/25.
//

import SwiftUI

struct SettingCardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var router: Router
    @Binding var showSignOutPopUp: Bool
    @Binding var showLogOutPopUp: Bool
    
    var body: some View {
        VStack {
            Text("개인정보 이용약관")
                .font(.pretendardSemiBold14)
                .foregroundStyle(.white)
                .onTapGesture {
                    router.push(.personalTerm)
                }
            Divider()
                .padding(8)
            if authViewModel.authenticationState == .guest {
                Button {
                    router.push(.authLogin)
                } label: {
                    Text("로그인")
                        .font(.pretendardSemiBold14)
                        .foregroundStyle(.white)
                }
            } else {
                Button {
                    withAnimation {
                        showLogOutPopUp = true
                    }
                } label: {
                    Text("로그아웃")
                        .font(.pretendardSemiBold14)
                        .foregroundStyle(.white)
                }
                Divider()
                    .padding(8)
                Button {
                    withAnimation {
                        showSignOutPopUp = true
                    }
                } label: {
                    Text("탈퇴하기")
                        .font(.pretendardSemiBold14)
                        .foregroundStyle(.white)
                }
            }
        }
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.tranquility)
        )
        .frame(maxWidth: .infinity)
    }
}

//struct SettingCardView_Previews: PreviewProvider {
//  static var previews: some View {
//      SettingCardView(showPopUp: .constant(false))
//  }
//}
