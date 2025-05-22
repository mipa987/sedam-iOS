//
//  PostViewModel.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

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
    
    func updatePost(title: String, content: String, id: String) async throws {
        _ = try await postService.updateOnePost(id: id, title: title, content: content)
    }
    
    func createNewPost(title: String, content: String) async throws {
        try await postService.createPost(title: title, content: content)
    }
    
    func deletePost(id: String) async throws {
        _ = try await postService.deleteOnePost(id: id)
    }
    
    func tapLike(id: String, isLiked: Bool) async throws {
        if isLiked {
            try await likeService.unlike(postId: id)
        } else {
            try await likeService.like(postId: id)
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
