//
//  MainView.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct PostMainView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject var viewModel: PostViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var date: Date = .now
    @State private var isCalendarPresented = false
    
    private var indexedPosts: [(offset: Int, element: PostDTO)] {
        Array(viewModel.postList.enumerated())
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // 1) 배경만 화면 전체 + safe area 무시
                Color.modernIvory
                    .ignoresSafeArea()
                
                // 2) 화면 전체 크기를 차지시키되, 내용은 위쪽 정렬
                VStack(spacing: 16) {
                    // 3) safe area 높이만큼 패딩
                    ThemeView(
                        date: $date,
                        words: $viewModel.todayWords,
                        wordsFont: .danjoBold18
                    )
                    
                    HStack {
                        Button {
                            isCalendarPresented.toggle()
                        } label: {
                            Image(systemName: "calendar")
                        }
                        
                        Button {
                            viewModel.togglePostListType()
                        } label : {
                            if viewModel.postListType.sort == .likes {
                                Image(systemName: "list.number")
                            } else {
                                Image(systemName: "clock")
                            }
                        }
                    }
                    
                    // 4) 남은 공간은 스크롤뷰로 채움
                    ScrollView {
                        ForEach($viewModel.postList.indices, id: \.self) { index in
                            PostListCellView(
                                rank: String(index + 1),
                                post: $viewModel.postList[index],
                                index: index
                            )
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 160) // 아래 여유 주기
                    }
                    Spacer()
                }
                .frame(
                    width: proxy.size.width,
                    height: proxy.size.height,
                    alignment: .top     // VStack 전체를 위쪽 정렬
                )
                .padding(.top, proxy.safeAreaInsets.top + 48)
                .onChange(of: date) { _, newDate in
                    date = newDate
                    viewModel.getTodayWords(by: date)
                    viewModel.fetchPostList(sortBy: .likes, order: .desc, date: date)
                }
                .sheet(isPresented: $isCalendarPresented) {
                    VStack {
                        var dateRange: ClosedRange<Date> {
                            let calendar = Calendar.current
                            let startComponents = DateComponents(year: 2025, month: 5, day: 20)
                            
                            return calendar.date(from: startComponents)!...Date()
                        }
                        DatePicker ( "", selection: $date, in: dateRange, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                        
                        Button("선택 완료") {
                            isCalendarPresented = false
                        }
                        .padding(.top, 16)
                        .font(.pretendardSemiBold14)
                    }
                }
                .task {
                    self.date = viewModel.postListType.startDate
                    viewModel.fetchPostList(sortBy: viewModel.postListType.sort, order: viewModel.postListType.order, date: viewModel.postListType.startDate)
                    userViewModel.fetchUserNickname()
                }
            }
        }
    }
}

//#Preview {
//    PostMainView()
//        .environmentObject(PostViewModel())
//}
