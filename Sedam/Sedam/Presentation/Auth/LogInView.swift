//
//  LogInView.swift
//  Sedam
//
//  Created by minsong kim on 4/23/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            VStack {
                LogoView(isVertical: true)
                    .padding(.vertical, 36)
                Text("세담")
                    .font(.danjoBold48)
                    .foregroundStyle(.black)
                    .padding(.vertical, 8)
                Text("매일 적는 3단어 담화")
                    .foregroundStyle(.black)
                    .font(.danjoBold18)
                
                Spacer().frame(height: 80)
                
                VStack(spacing: 12) {
                    ForEach(LogIn.allCases, id:\.self) { type in
                        LoginButton(type: type)
                            .onTapGesture {
                                switch type {
                                case .apple:
                                    viewModel.send(type: .apple)
                                case .kakao:
                                    viewModel.send(type: .kakao)
                                }
                            }
                    }
                    
                    HStack {
                        Text("손님으로 볼게요")
                            .font(.danjoBold14)
                            .foregroundStyle(.dadsCoupe)
                    }
                    .padding(.vertical, 24)
                    .onTapGesture {
                        viewModel.authenticationState = .guest
                        KeyChainModule.create(key: .guestMode, data: "true")
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 20, trailing: 24))
            }
        }
    }
}

//#Preview {
//    @Previewable @State var authVM = AuthViewModel()
//    LoginView(viewModel: authVM)
//}
