//
//  LogInView.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import SwiftUI

struct LoginView: View {
    @Binding var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.ivory
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 4) {
                    Image(.heartBubble)
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(.squareBubble)
                        .resizable()
                        .frame(width: 30, height: 30)
                    Image(.roundBubble)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                .padding(.vertical, 36)
                Text("세담")
                    .font(.danjoBold48)
                    .padding(.vertical, 8)
                Text("매일 적는 3단어 담화")
                    .font(.danjoBold18)
                
                Spacer().frame(height: 80)
                
                VStack(spacing: 12) {
                    ForEach(LogIn.allCases, id:\.self) { type in
                        LoginButton(type: type)
                            .onTapGesture {
                                switch type {
                                case .apple:
                                    viewModel.send(action: .appleSignIn)
                                case .kakao:
                                    break
                                }
                            }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 20, trailing: 24))
            }
        }
    }
}

#Preview {
    @Previewable @State var authVM = AuthViewModel()
    LoginView(viewModel: $authVM)
}
