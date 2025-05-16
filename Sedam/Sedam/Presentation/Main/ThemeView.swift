//
//  ThemeView.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

struct ThemeView: View {
    @EnvironmentObject var viewModel: PostViewModel
    @State private var date: Date = .now
    @State private var isCalendarPresented = false
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 8) {
            LogoView(size: 20)
            Text("\(dateFormatter.string(from: date))의 3단어")
                .font(.danjoBold14)
            Text(viewModel.todayWords.joined(separator: ", "))
                .font(.danjoBold18)
            LogoView(size: 20)
            
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
        }
        .foregroundStyle(.black)
        .onChange(of: date) { _, newDate in
            date = newDate
            viewModel.getTodayWords(by: date)
            viewModel.fetchPostList(sortBy: .likes, order: .desc, date: date)
        }
        .sheet(isPresented: $isCalendarPresented) {
            VStack {
                DatePicker ( "", selection: $date, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                
                Button("선택 완료") {
                    isCalendarPresented = false
                }
                .padding(.top, 16)
            }
        }
        .task {
            self.date = viewModel.postListType.startDate
        }
    }
}

#Preview {
    ThemeView()
}
