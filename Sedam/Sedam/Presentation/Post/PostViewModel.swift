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
    @Published var isCreatedPost: Bool = false
    
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
    
    func createNewPost(title: String, content: String) {
        errorMessage = nil
        self.isCreatedPost = false
        
        Task { @MainActor in
            do {
                try await postService.createPost(title: title, content: content)
                self.isCreatedPost = true
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func deletePost(id: UUID) {
        errorMessage = nil
        
        Task { @MainActor in
            do {
                try await postService.deletePost(id: id)
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

