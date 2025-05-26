//
//  NetworkManager.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation
import Supabase

class NetworkManager {
    // MARK: - Public
    func fetchData<Builder: BuilderProtocol>(_ builder: Builder, isRetry: Bool = false) async throws -> Builder.Response {
        let request = try await makeRequest(builder)
        let (data, response) = try await URLSession.shared.data(for: request)
        if let string = String(data: data, encoding: .utf8) {
            print("Response Body:", string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseNotFound
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return try await builder.deserializer.deserialize(data)
            
        case 401 where !isRetry:
            // 2) 토큰 갱신 시도
            try await refreshToken()
            // 3) 토큰 갱신 후, 재시도 플래그를 true로 해서 재요청
            return try await fetchData(builder, isRetry: true)
            
        case 401:
            throw NetworkError.accessDenied
            
        default:
            throw NetworkError.invalidStatus(httpResponse.statusCode)
        }
    }
    
    // MARK: - Private
    private func makeRequest<Builder: BuilderProtocol>(_ builder: Builder) async throws -> URLRequest {
        guard let baseURL = URL(string: builder.baseURL.rawValue) else {
            throw NetworkError.urlNotFound
        }
        
        var url = baseURL.appendingPathComponent(builder.path)
        url.append(queryItems: builder.queries ?? [])
        
        var request = URLRequest(url: url)
        builder.headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if builder.useAuthorization {
            let accesstoken = KeyChainModule.read(key: .accessToken) ?? ""
            request.setValue("Bearer \(accesstoken)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpMethod = builder.method.typeName
        
        if builder.method != .get {
            request.httpBody = try await builder.serializer.serialize(builder.parameters)
        }
        
        return request
    }
    
    private func refreshToken() async throws {
        // (선택) 앱 포그라운드 진입 시 자동 갱신 루프 시작
        await SupabaseManager.shared.supabase.auth.startAutoRefresh()
        // 세션을 가져오기만 해도, 만료 시 리프레시가 이루어집니다
        let session = try await SupabaseManager.shared.supabase.auth.session   // :contentReference[oaicite:1]{index=1}
        
        // 최신 토큰을 Keychain에 저장
        KeyChainModule.create(key: .accessToken, data: session.accessToken)
        KeyChainModule.create(key: .refreshToken, data: session.refreshToken)
        print("✅Successfully refreshed token")
    }
}
