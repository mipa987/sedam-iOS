//
//  TabContainerView.swift
//  Sedam
//
//  Created by minsong kim on 4/29/25.
//

import SwiftUI

struct TabContainerView: View {
    @EnvironmentObject private var router: Router
    @State private var selectedTab: Tab = .home

    var body: some View {
        ZStack {
            // 1) 탭별 화면 분기
            Group {
                switch selectedTab {
                case .home:
                    PostMainView()
                case .myPage:
                    MyPageView()
                case .createPost:
                    // + 버튼 누르면 라우터로 push
                    Color.clear
                        .onAppear {
                            router.push(.createPost)
                            // + 탭 선택 효과가 남지 않도록 다시 홈으로
                            selectedTab = .home
                        }
                }
            }
            .ignoresSafeArea()

            // 2) 화면 아래에 탭 바
            VStack {
                Spacer()
                CustomTabView(selectedTab: $selectedTab)
                    .padding(.horizontal)
            }
            .ignoresSafeArea()
        }
    }
}
