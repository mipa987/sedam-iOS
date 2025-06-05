import Foundation
import Supabase

class TermsService {
    private let networkManager: NetworkManager
    private let supabase = SupabaseManager.shared.supabase

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func hasAgreed(to term: TermName) async throws -> Bool {
        let builder = CheckTermsAgreeBuilder(termTitle: term.name)
        
        return try await networkManager.fetchData(builder).agreed
    }

    func agree(to term: TermName) async throws {
        let builder = AgreeTermsBuilder(termTitle: term.name, httpMethod: .post)
        
        _ = try await networkManager.fetchData(builder)
    }
}
