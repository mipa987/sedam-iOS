//
//  NetworkManager.swift
//  Sedam
//
//  Created by minsong kim on 5/12/25.
//

import Foundation

class NetworkManager {
    // MARK: - Public
    func fetchData<Builder: BuilderProtocol>(_ builder: Builder) async throws -> Builder.Response {
        let request = try await makeRequest(builder)
        let (data, response) = try await URLSession.shared.data(for: request)
        if let string = String(data: data, encoding: .utf8) {
            print("Response Body:", string)
        }
        //Error
        let decodedData: Builder.Response = try await builder.deserializer.deserialize(data)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseNotFound
        }
        
        if (200...299).contains(httpResponse.statusCode) {
            return decodedData
        } else {
            print(httpResponse.statusCode)
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
}
