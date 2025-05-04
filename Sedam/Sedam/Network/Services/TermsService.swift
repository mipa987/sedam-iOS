import Foundation
import Supabase

class TermsService {
    static let shared = TermsService()
    private let supabase = SupabaseManager.shared.supabase

    func getTermId(to term: TermName) async throws -> UUID {
        let terms: [Term] = try await supabase
            .from("terms")
            .select()
            .eq("title", value: term.rawValue)
            .limit(1)
            .execute()
            .value

        guard let termId = terms.first?.id else {
            throw TermError.cannotFindTerm
        }

        return termId
    }

    func hasAgreed(to term: TermName) async throws -> Bool {
        guard let userId = supabase.auth.currentUser?.id else {
            throw TermError.notLoggedIn
        }
        let termId = try await getTermId(to: term)

        // 약관 동의 여부 반환
        let userTerms: [UserTerm] = try await supabase
            .from("user_terms")
            .select()
            .eq("user_id", value: userId)
            .eq("terms_id", value: termId)
            .limit(1)
            .execute()
            .value

        return !userTerms.isEmpty
    }

    func agree(to term: TermName) async throws {
        guard let userId = supabase.auth.currentUser?.id else {
            throw TermError.notLoggedIn
        }
        let termId = try await getTermId(to: term)

        // 2. 기존에 이미 동의했는지 확인
        let existing: [UserTerm] = try await supabase
            .from("user_terms")
            .select("id")
            .eq("user_id", value: userId)
            .eq("terms_id", value: termId)
            .limit(1)
            .execute()
            .value

        if !existing.isEmpty {
            throw TermError.alreadyAgreed
        }

        // 3. 동의 내역 insert
        _ = try await supabase
            .from("user_terms")
            .insert([
                "user_id": userId.uuidString,
                "terms_id": termId.uuidString
            ])
            .execute()
    }
}
