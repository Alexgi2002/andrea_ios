//
//  AuthViewModel.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//
import Foundation

@MainActor
@Observable
class AuthViewModel {
    private var repo : AuthRepository = AuthRepositoryImpl()
    
    var isLoading: Bool = false
    
    
    func login(username: String, password: String, fcmToken: String?, deviceName: String) {
        Task{
            do {
                isLoading = true
                
                let response = try await repo.login(username: username, password: password, fcmToken: fcmToken, deviceName: deviceName)
            
                AuthManager.shared.login(token: response.token)
                
            } catch {
                print(error)
            }
                
            isLoading = false
        }
    }
    
    func register() {
        
        
    }
}
