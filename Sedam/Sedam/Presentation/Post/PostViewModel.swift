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
    @Published var selectedPost: Post?
    
    private let postService = PostService.shared
    
    func fetchPostList() {
        isLoading = true
        errorMessage = nil
        
        Task {
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
        
        Task {
            do {
                try await postService.createPost(title: title, content: content)
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func getPost(id: UUID) {
        errorMessage = nil
        
        Task {
            do {
                selectedPost = try await postService.fetchPost(by: id)
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

