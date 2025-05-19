//
//  SinglePopUpView.swift
//  Sedam
//
//  Created by minsong kim on 5/16/25.
//

import SwiftUI

struct SinglePopUpView: View {
    @Binding var showPopUp: Bool
    
    let title: String
    let message: String
    let buttonText: String
    var buttonAction: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.black)
                .opacity(0.2)
            
            VStack(spacing: 12) {
                Text(title)
                    .frame(height: 30)
                    .font(.maruburiSemibold14)
                    .padding(.top, 12)
                
                Text(message)
                    .multilineTextAlignment(.center)
                    .padding(12)
                    .font(.maruburiRegular14)
                
                Button {
                    buttonAction()
                } label: {
                    Text(buttonText)
                        .font(.pretendardSemiBold14)
                        .foregroundStyle(.white)
                        .padding(8)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.juniperBerries)
                )
                .frame(height: 44)
                .padding(.bottom, 12)
            }
            .background(.modernIvory)
            .roundedCorner(16, corners: .allCorners)
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SinglePopUpView(
        showPopUp: .constant(true),
        title: "로그인",
        message: "로그인이 필요한 기능입니다.",
        buttonText: "로그인하러 가기",
        buttonAction: { print("로그인 이동") }
    )
}
