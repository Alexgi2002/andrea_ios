//
//  HomeRepository.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

class HomeRepositoryImpl: HomeRepository {
    private let apiClient = APIClient.shared
    
    private let path = "social"
    
    func feed() async throws -> [UserDTO] {
        let response = try await apiClient.getData(from: path + "/feed", as: [UserDTO].self)
        
        return response
    }
    
    func me() async throws -> UserDTO {
        let response = try await apiClient.getData(from: "me", as: UserDTO.self)
        
        return response
    }
}
