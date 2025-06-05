//
//  TodayWordService.swift
//  Sedam
//
//  Created by 여성찬 on 4/29/25.
//

import Foundation

final class TodayWordService {
    private let networkManager: NetworkManager
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
    }()

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchTodayWords() async throws -> [String] {
        let builder = TodayWordsBuilder()
        
        return try await networkManager.fetchData(builder)
    }
    
    func fetchWords(by date: Date) async throws -> [String] {
        let stringDate = dateFormatter.string(from: date)
        let builder = ByDateWordsBuilder(date: stringDate)
        
        return try await networkManager.fetchData(builder)
    }
}
