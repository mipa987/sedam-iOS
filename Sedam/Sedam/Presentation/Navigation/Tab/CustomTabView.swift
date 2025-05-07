//
//  CustomTabView.swift
//  Sedam
//
//  Created by minsong kim on 4/28/25.
//

import SwiftUI

enum Tab {
    case home
    case myPage
    case createPost
}

struct CustomTabView: View {
    @Binding var selectedTab: Tab
    @State private var isTapped: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.tranquility)
                .opacity(0.6)
            HStack {
                Spacer()
                Button() {
                    selectedTab = .home
                } label: {
                    Image(systemName: selectedTab == .home ? "house.fill" : "house")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundStyle(.white)
                }
                Spacer()
                ZStack {
                    Circle()
                        .foregroundStyle(.juniperBerries)
                        .frame(width: 80, height: 80)
                    Button {
                        selectedTab = .createPost
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundStyle(.white)
                    }
                }
                .offset(y: -36)
                Spacer()
                Button {
                    selectedTab = .myPage
                } label: {
                    Image(systemName: selectedTab == .myPage ? "person.fill" : "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundStyle(.white)
                }
                Spacer()
            }
        }
        .frame(height: 80)
    }
}

#Preview {
    @Previewable @State var tab = Tab.myPage
        CustomTabView(selectedTab: $tab)
}
