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
    
    private var token : String?
    
    private init() {
        let configuration = URLSessionConfiguration.default
        
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 60.0
        configuration.allowsCellularAccess = true
        configuration.waitsForConnectivity = true
        
        self.session = URLSession(configuration: configuration)
        
        token = UserDefaults.standard.string(forKey: "userToken")
    }
    
    private func updateToken (token: String) {
        self.token = token
    }
    
    
    private func adaptRequest(_ request: URLRequest) -> URLRequest {
        guard token != nil else {
            return request
        }
        
        var authenticatedRequest = request
        authenticatedRequest.setValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        return authenticatedRequest
    }
    
    func getData(from path: String) async throws -> Data {
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = "GET"
                
        let finalRequest = adaptRequest(request)
        
        let (data, _) = try await session.data(for: finalRequest)
        return data
    }
    
    func postData(from path: String, body: [String: Any]) async throws -> Data {
        var request = URLRequest(url: self.url.appendingPathComponent(path))
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let finalRequest = adaptRequest(request)
        
        let (data, _) = try await session.data(for: finalRequest)
        return data
    }
}
