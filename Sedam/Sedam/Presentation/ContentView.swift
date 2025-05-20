//
//  ContentView.swift
//  Sedam
//
//  Created by minsong kim on 5/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isLaunch: Bool = true
    
    var body: some View {
        if isLaunch {
            LaunchView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeIn(duration: 1)) {
                            self.isLaunch = false
                        }
                    }
                }
        } else {
            AuthenticatedView()
        }
    }
}
