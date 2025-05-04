//
//  TodayWordService.swift
//  Sedam
//
//  Created by 여성찬 on 4/29/25.
//

import Foundation
import Supabase

final class TodayWordService {
    static let shared = TodayWordService()

    private let client = SupabaseManager.shared.supabase

    private func todayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter.string(from: Date())
    }

    func fetchTodayWords() async throws -> [String] {
        let today = todayString()

        let response = try await client
            .from("today_words")
            .select()
            .eq("word_date", value: today)
            .execute()

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        decoder.dateDecodingStrategy = .formatted(formatter)

        let todayWords = try decoder.decode([TodayWord].self, from: response.data)

        return todayWords.map { $0.word }.prefix(3).map { String($0) }
    }
}
