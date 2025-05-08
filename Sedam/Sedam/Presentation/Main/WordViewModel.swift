//
//  WordViewModel.swift
//  Sedam
//
//  Created by minsong kim on 5/8/25.
//

import Foundation

class WordViewModel: ObservableObject {
    @Published var words: [String] = []
    
    @MainActor
    func getTodayWords() {
        Task {
            do {
                words = try await TodayWordService.shared.fetchTodayWords()
            } catch {
                debugPrint("❌word error: \(error.localizedDescription)")
            }
        }
    }
}
