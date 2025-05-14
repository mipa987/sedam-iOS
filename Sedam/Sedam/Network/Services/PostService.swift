//
//  PostService.swift
//  Sedam
//
//  Created by 여성찬 on 4/25/25.
//

import Foundation
import Supabase

enum SortType {
    case createdAt
    case likes
    
    var name: String {
        switch self {
        case .createdAt:
            "created_at"
        case .likes:
            "likes"
        }
    }
}

enum OrderType {
    case asc
    case desc
    
    var name: String {
        switch self {
        case .asc:
            "asc"
        case .desc:
            "desc"
        }
    }
}

final class PostService {
    static let shared = PostService()
    let networkManager = NetworkManager()
    
    //정렬 기준에 따라 모든 post 불러오기
    func fetchPostList(sortBy: SortType, order: OrderType, startDate: String? = nil, endDate: String? = nil) async throws -> [PostDTO] {
        let builder = PostBuilder(httpMethod: .get, sort: sortBy.name, order: order.name, startDate: startDate, endDate: endDate)
        
        return try await networkManager.fetchData(builder)
    }
    
    //새로운 post 생성하기
    func createPost(title: String, content: String) async throws {
        let builder = PostBuilder(parameters: ["title": title, "content": content])
        
        _ = try await networkManager.fetchData(builder)
    }
    
    //정렬 기준에 따라 내 post 불러오기
    func fetchMyPostList(sortBy: SortType, order: OrderType, startDate: String? = nil, endDate: String? = nil) async throws -> [PostDTO] {
        let builder = MyPostBuilder(sort: sortBy.name, order: order.name, startDate: startDate, endDate: endDate)
        
        return try await networkManager.fetchData(builder)
    }
    
    //단일 post 조회하기
    func fetchOnePost(id: String) async throws -> PostDTO {
        let builder = PostDetailBuilder<PostDTO>(httpMethod: .get, id: id)
        
        return try await networkManager.fetchData(builder)
    }
    
    //post 내용 업데이트 하기
    func updateOnePost(id: String, title: String, content: String) async throws -> PostDTO {
        let builder = PostDetailBuilder<PostDTO>(id: id, parameters: ["title": title, "content": content])
        
        return try await networkManager.fetchData(builder)
    }
    
    //post 삭제하기
    func deleteOnePost(id: String) async throws {
        let builder = PostDetailBuilder<ResponseDTO>(httpMethod: .delete, id: id)
        
        _ = try await networkManager.fetchData(builder)
    }
}
