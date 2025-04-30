//
//  PostViewModel.swift
//  Sedam
//
//  Created by minsong kim on 4/25/25.
//

import SwiftUI

class PostViewModel: ObservableObject {
    @Published var postList: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let postService = PostService.shared
    
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
    
    func createNewPost(title: String, content: String) async throws {
        try await postService.createPost(title: title, content: content)
    }
    
    func deletePost(id: UUID) async throws {
        try await postService.deletePost(id: id)
    }
}

