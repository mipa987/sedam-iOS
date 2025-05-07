//
//  UserCardView.swift
//  세담
//
//  Created by minsong kim on 5/7/25.
//

import SwiftUI

struct UserCardView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Button {
                //user nickname 변경
            } label: {
                Text("고양이 MIPA")
                    .font(.danjoBold24)
                    .foregroundStyle(.white)
            }
            Divider()
            HStack {
                Button {
                    authViewModel.logOut()
                } label: {
                    Text("로그아웃")
                        .font(.danjoBold18)
                        .foregroundStyle(.white)
                }
                Divider()
                Button {
                    authViewModel.signOut()
                } label: {
                    Text("탈퇴하기")
                        .font(.danjoBold18)
                        .foregroundStyle(.white)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.juniperBerries)
                .shadow(color: .black.opacity(0.1),
                        radius: 4, x: 0, y: 2)
        )
        .padding()
        .frame(height: 150)
    }
}
