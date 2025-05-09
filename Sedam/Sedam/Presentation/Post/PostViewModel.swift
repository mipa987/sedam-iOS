//
//  PostViewModel.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

class PostViewModel: ObservableObject {
    @Published var postList: [Post] = []
    @Published var myPostList: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let postService = PostService.shared
    private let likeService = LikeService.shared
    
    func fetchPostList() {
        isLoading = true
        errorMessage = nil
        
        Task { @MainActor in
            do {
                let loaded = try await postService.fetchAllPosts()
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
                let loaded = try await postService.fetchMyPosts()
                self.myPostList = loaded
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func createNewPost(title: String, content: String) async throws {
        try await postService.createPost(title: title, content: content)
    }
    
    func deletePost(id: UUID) async throws {
        try await postService.deletePost(id: id)
    }
    
    func tapLike(id: UUID, isLiked: Bool) async throws {
        if isLiked {
            try await likeService.unlike(postId: id)
        } else {
            try await likeService.like(postId: id)
        }
    }
    
    func isLiked(id: UUID) async throws -> Bool {
        try await likeService.hasLiked(postId: id)
    }
}

