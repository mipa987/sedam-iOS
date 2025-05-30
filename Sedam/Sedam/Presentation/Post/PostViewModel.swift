//
//  PostViewModel.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import Combine
import SwiftUI

@MainActor
class PostViewModel: ObservableObject {
    @Published var postList: [PostDTO] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var todayWords: [String] = []
    @Published var postListType = PostListType()
    
    private let postService = PostService.shared
    private let likeService = LikeService.shared
    private let wordService = TodayWordService.shared
    private let postCreatedSubject = PassthroughSubject<Void, Never>()
    private let postDeletedSubject = PassthroughSubject<Void, Never>()
    private let postUpdateSubject = PassthroughSubject<Void, Never>()
    
    var postCreatedPublisher: AnyPublisher<Void, Never> {
        postCreatedSubject.eraseToAnyPublisher()
    }
    
    var postDeletedPublisher: AnyPublisher<Void, Never> {
        postDeletedSubject.eraseToAnyPublisher()
    }
    
    var postUpdatedPublisher: AnyPublisher<Void, Never> {
        postUpdateSubject.eraseToAnyPublisher()
    }
    
    init() {
        getTodayWords(by: .now)
        fetchPostList(sortBy: postListType.sort, order: postListType.order)
    }
    
    func togglePostListType() {
        if postListType.sort == .createdAt {
            postListType.sort = .likes
        } else {
            postListType.sort = .createdAt
        }
        
        fetchPostList(sortBy: postListType.sort, order: postListType.order, date: postListType.startDate)
    }
    
    private func changePostListType(sortBy: SortType, order: OrderType, date: Date) {
        postListType = PostListType(sort: sortBy, order: order, startDate: date, enddate: date)
        
        fetchPostList(sortBy: sortBy, order: order, date: date)
    }
    
    func fetchPostList(sortBy: SortType, order: OrderType, date: Date = .now) {
        isLoading = true
        errorMessage = nil
        postListType = PostListType(sort: sortBy, order: order, startDate: date, enddate: date)
        
        Task {
            do {
                let loaded = try await postService.fetchPostList(sortBy: sortBy, order: order, startDate: date, endDate: date)
                self.postList = loaded
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    func fetchPostDetail(id: String) async throws -> PostDTO {
        return try await postService.fetchOnePost(id: id)
    }
    
    func updatePost(title: String, content: String, id: String) {
        Task {
            do {
                _ = try await postService.updateOnePost(id: id, title: title, content: content)
                //                return publisher.map(true)
                //TODO: 성공시 성공했다고 반환, router.pop() 필요 (진동과 함께)
                postUpdateSubject.send()
            } catch NetworkError.accessDenied {
                NotificationCenter.default.post(name: .loginRequired, object: nil)
            } catch {
                print("❌ error: \(error.localizedDescription)")
            }
        }
    }
    
    func createNewPost(title: String, content: String) {
        Task {
            do {
                try await postService.createPost(title: title, content: content)
                postCreatedSubject.send()
            } catch NetworkError.accessDenied {
                NotificationCenter.default.post(name: .loginRequired, object: nil)
            } catch {
                print("❌ error: \(error.localizedDescription)")
            }
        }
    }
    
    func deletePost(id: String) {
        Task {
            do {
                _ = try await postService.deleteOnePost(id: id)
                postDeletedSubject.send()
            } catch NetworkError.accessDenied {
                NotificationCenter.default.post(name: .loginRequired, object: nil)
            } catch {
                print("❌ error: \(error.localizedDescription)")
            }
        }
    }
    
    func tapLike(id: String, isLiked: Bool) {
        Task {
            do {
                if isLiked {
                    try await likeService.unlike(postId: id)
                } else {
                    try await likeService.like(postId: id)
                }
            } catch NetworkError.accessDenied {
                NotificationCenter.default.post(name: .loginRequired, object: nil)
            } catch {
                print("❌ error: \(error.localizedDescription)")
            }
        }
    }
    
    func isLiked(id: String) async throws -> Bool {
        return try await likeService.hasLiked(postId: id)
    }
    
    func getTodayWords(by date: Date) {
        Task {
            do {
                todayWords = try await wordService.fetchWords(by: date)
            } catch {
                debugPrint("❌word error: \(error.localizedDescription)")
            }
        }
    }
}

struct PostListType {
    var sort: SortType = .likes
    var order: OrderType = .desc
    var startDate: Date = .now
    var enddate: Date = .now
}
