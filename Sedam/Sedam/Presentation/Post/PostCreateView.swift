//
//  PostCreateView.swift
//  Sedam
//
//  Created by minsong kim on 4/28/25.
//

import SwiftUI

struct PostCreateView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: PostViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var title: String = ""
    @State var content: String = ""
    @FocusState private var isTextEditorFocused: Bool
    @State var showLogInPopUp: Bool = false
    
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
                .onTapGesture {
                    // 2) 배경 터치 시 포커스 해제
                    isTextEditorFocused = false
                }
            
            VStack(alignment: .center) {
                LogoView(size: 10)
                Text(viewModel.todayWords.joined(separator: ", "))
                    .font(.maruburiSemibold14)
                TextField("제목을 입력하세요.", text: $title)
                    .font(.maruburiBold24)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                LogoView(size: 10)
                VStack {
                    ZStack(alignment: .topLeading) {
                        if content.isEmpty {
                            Text("3가지 단어가 모두 들어간 글을 작성해주세요.")
                                .foregroundStyle(.gray)
                                .font(.maruburiRegular14)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 28)
                        }
                        TextEditor(text: $content)
                            .focused($isTextEditorFocused)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 24)
                            .multilineTextAlignment(.leading)
                            .font(.maruburiRegular14)
                            .lineSpacing(12)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                    }
                }.overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.dadsCoupe, lineWidth: 2)
                        .padding(.horizontal, 24)
                )
                MainButton(title: "등록", font: .pretendardSemiBold18, color: .dadsCoupe)
                    .tap() {
                        Task { @MainActor in
                            do {
                                try await viewModel.createNewPost(title: title, content: content)
                                router.pop()
                            } catch NetworkError.accessDenied {
                                withAnimation {
                                    showLogInPopUp = true
                                }
                            } catch {
                                print("❌ error: \(error.localizedDescription)")
                            }
                        }
                    }
                    .padding(.horizontal, 24)
            }
            Spacer()
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

#Preview {
    PostCreateView(title: "",content: "")
        .environmentObject(PostViewModel())
}
