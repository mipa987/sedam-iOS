import Foundation
import Supabase

class TermsService {
    static let shared = TermsService()
    private let networkManager = NetworkManager()
    private let supabase = SupabaseManager.shared.supabase
    
    func hasAgreed(to term: TermName) async throws -> Bool {
        let builder = CheckTermsAgreeBuilder(termTitle: term.name)
        
        return try await networkManager.fetchData(builder).agreed
    }

    func agree(to term: TermName) async throws {
        let builder = AgreeTermsBuilder(termTitle: term.name, httpMethod: .post)
        
        _ = try await networkManager.fetchData(builder)
    }
}
