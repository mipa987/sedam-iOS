//
//  PostViewModel.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

class PostViewModel: ObservableObject {
    @Published var postList: [PostDTO] = []
    @Published var myPostList: [PostDTO] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let postService = PostService.shared
    private let likeService = LikeService.shared
    
    @MainActor
    func fetchPostList(sortBy: SortType, order: OrderType) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let loaded = try await postService.fetchPostList(sortBy: sortBy, order: order)
                self.postList = loaded
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
    
    @MainActor
    func fetchMyPostList() {
        isLoading = true
        errorMessage = nil
        
        Task { 
            do {
                let loaded = try await postService.fetchMyPostList(sortBy: .createdAt, order: .desc)
                self.myPostList = loaded
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchPostDetail(id: String) async throws -> PostDTO {
        return try await postService.fetchOnePost(id: id)
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
}
