//
//  AuthService.swift
//  Sedam
//
//  Created by 여성찬 on 4/27/25.
//

import Foundation

class UserService {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func createRandomNickname() async throws -> String {
        let builder = NicknameCreateBuilder()
        
        return try await networkManager.fetchData(builder).message
    }
    
    func fetchNickname() async throws -> String {
        let builder = NicknameBuilder(http: .get)
        
        return try await networkManager.fetchData(builder).nickname
    }
    
    func updateNickname(for nickname: String) async throws {
        let builder = NicknameBuilder(http: .post, parameters: ["nickname": nickname])
        
        _ = try await networkManager.fetchData(builder)
    }

    func deleteUser() async throws {
        let builder = DeleteUserBuilder()
        
        _ = try await networkManager.fetchData(builder)
    }
}
