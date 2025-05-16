//
//  UserViewModel.swift
//  Sedam
//
//  Created by minsong kim on 5/14/25.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var name: String = "손님"
    
    @MainActor
    func fetchUserNickname() {
        Task {
            do {
                name = try await UserService.shared.fetchNickname()
            } catch {
                name = "손님"
                print("❌ error: \(error.localizedDescription)")
            }
        }
    }
}

//struct User {
//    var shared: User = User()
//    
//    private init() {}
//    
//    var nickname: String = "손님"
//}
