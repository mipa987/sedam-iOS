//
//  ContentView.swift
//  Sedam
//
//  Created by minsong kim on 5/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isLaunch: Bool = true
    private let baseURL: BaseURLType = .production
    
    private var networkManager: NetworkManager {
        guard let url = URL(string: baseURL.rawValue) else {
            fatalError("Invalid base URL")
        }
        
        return NetworkManager(baseURL: url)
    }
    
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
                .environmentObject(AuthViewModel(networkManager: networkManager))
                .environmentObject(PostViewModel(networkManager: networkManager))
                .environmentObject(UserViewModel(networkManager: networkManager))
        }
    }
}
