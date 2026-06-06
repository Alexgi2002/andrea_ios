//
//  NetworkClient.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//
import Foundation

class APIClient {
    static let shared = APIClient()
    
    private let session: URLSession
    private let url = URL(string: "https://andrea-dev.cemisoft.cu/api/v1/")!
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 60.0
        configuration.allowsCellularAccess = true
        configuration.waitsForConnectivity = true
        
        self.session = URLSession(configuration: configuration)
        
        
        decoder.dateDecodingStrategy = .iso8601
    }
    
    private func interceptResponse(_ response: URLResponse) async throws {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        print(httpResponse.statusCode)
        
        if httpResponse.statusCode == 401 {
            await MainActor.run {
                AuthManager.shared.logout()
            }
            throw URLError(.userAuthenticationRequired)
        }
    }
    
    private func adaptRequest(_ request: URLRequest) -> URLRequest {
        guard let currentToken = AuthManager.shared.token else {
            return request
        }
        
        var authenticatedRequest = request
        authenticatedRequest.setValue("Bearer \(currentToken)", forHTTPHeaderField: "Authorization")
        return authenticatedRequest
    }
    
    
    func getData<T: Decodable>(from path: String, as type: T.Type) async throws -> T {
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = "GET"
                
        let finalRequest = adaptRequest(request)
        
        let (data, response) = try await session.data(for: finalRequest)
        try await interceptResponse(response)
        
        let serverResponse = try decoder.decode(CustomResponse<T>.self, from: data)
        
        if serverResponse.isError {
            throw APIError.backendError(message: serverResponse.error?.message ?? serverResponse.message ?? "Error desconocido del servidor")
        }
        
        guard let resultData = serverResponse.data else {
            throw APIError.noData
        }
        
        return resultData
    }
    
    
    func postData<T: Decodable, B: Encodable>(from path: String, body: B, responseType: T.Type) async throws -> T {
        var request = URLRequest(url: self.url.appendingPathComponent(path))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try encoder.encode(body)
        
        let finalRequest = adaptRequest(request)
        
        let (data, response) = try await session.data(for: finalRequest)
        try await interceptResponse(response)
        
        let serverResponse = try decoder.decode(CustomResponse<T>.self, from: data)
        
        if serverResponse.isError {
            throw APIError.backendError(message: serverResponse.error?.message ?? serverResponse.message ?? "Error desconocido del servidor")
        }
        
        guard let resultData = serverResponse.data else {
            throw APIError.noData
        }
        
        return resultData
    }
}

