//
//  CustomPopUpView.swift
//  Sedam
//
//  Created by minsong kim on 5/16/25.
//

import SwiftUI

struct CustomPopUpView: View {
    @Binding var showPopUp: Bool
    
    let title: String
    let message: String
    let leftButtonText: String
    let rightButtonText: String
    var leftButtonAction: () -> Void
    var rightButtonAction: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(.black)
                .opacity(0.2)
            
            VStack(spacing: 12) {
                Text(title)
                    .frame(height: 30)
                    .font(.danjoBold18)
                    .padding(.top, 12)
                
                Text(message)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
                    .font(.danjoBold14)
                
                HStack {
                    Button {
                        leftButtonAction()
                    } label: {
                        Text(leftButtonText)
                            .font(.pretendardSemiBold14)
                            .foregroundStyle(.white)
                            .padding(.vertical, 12)
                            .frame(width: 100)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.tranquility)
                    )
                    
                    Button {
                        rightButtonAction()
                    } label: {
                        Text(rightButtonText)
                            .font(.pretendardSemiBold14)
                            .foregroundStyle(.white)
                            .padding(.vertical, 12)
                            .frame(width: 100)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.juniperBerries)
                    )
                }
                .padding(.bottom, 12)
            }
            .frame(width: 300)
            .background(.modernIvory)
            .roundedCorner(16, corners: .allCorners)
        }
        .ignoresSafeArea(.all)
    }
}
