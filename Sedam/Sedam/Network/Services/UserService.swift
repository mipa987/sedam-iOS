//
//  AuthService.swift
//  Sedam
//
//  Created by 여성찬 on 4/27/25.
//

import Foundation

struct DeleteUserRequest: Codable {
    let user_id: UUID
}

class UserService {
    static let shared = UserService()

    private let lambdaURL = URL(string: Bundle.main.object(forInfoDictionaryKey: "LAMBDA_URL") as? String ?? "")!
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "LAMBDA_APP_KEY") as? String ?? ""

    func deleteUser() async throws {
        guard let userId = SupabaseManager.shared.supabase.auth.currentUser?.id else {
            throw UserError.notLoggedIn
        }

        var request = URLRequest(url: lambdaURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")

        let deleteRequest = DeleteUserRequest(user_id: userId)
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(deleteRequest)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        if (200 ... 299).contains(httpResponse.statusCode) {
            print("✅ User deletion succeeded")
        } else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw UserError.deleteUserError(reason: body)
        }
    }
}
