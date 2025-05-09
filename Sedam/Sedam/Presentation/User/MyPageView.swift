//
//  MyPageView.swift
//  세담
//
//  Created by minsong kim on 5/7/25.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        ZStack {
            Color.modernIvory
                .ignoresSafeArea()
            
            VStack {
                UserCardView()
                    .padding(.horizontal, 16)
                    .frame(height: 100)
                SettingCardView()
                    .padding(.horizontal, 16)
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
  static var previews: some View {
    MyPageView()
  }
}
