//
//  UserViewModel.swift
//  Sedam
//
//  Created by minsong kim on 5/14/25.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var name: String = ""
    
    @MainActor
    func fetchUserNickname() {
        Task {
            do {
                name = try await UserService.shared.fetchNickname()
            } catch {
                print("❌ error: \(error.localizedDescription)")
            }
        }
    }
}
