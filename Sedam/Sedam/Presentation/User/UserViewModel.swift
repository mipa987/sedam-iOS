//
//  UserViewModel.swift
//  Sedam
//
//  Created by minsong kim on 5/14/25.
//

import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var name: String = "손님"
    @Published var myPostList: [PostDTO] = []
    
    private let postService = PostService.shared
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        return formatter
    }()
    
    @MainActor
    func setNickname() async throws {
        name = try await UserService.shared.createRandomNickname()
    }
    
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
    
    func fetchMyPostList() {
        let dateString: String = "2025-05-20"
        let startDate = dateFormatter.date(from: dateString)!
        Task {
            do {
                self.myPostList = try await postService.fetchMyPostList(sortBy: .createdAt, order: .desc, startDate: startDate)
            } catch NetworkError.accessDenied {
                NotificationCenter.default.post(name: .loginRequired, object: nil)
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
