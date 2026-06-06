//
//  AuthManager.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

import Foundation

enum AuthState {
    case authenticated
    case noAuthenticated
}

@Observable
class AuthManager {
    static let shared = AuthManager()
    
    var token: String? {
        get {
            UserDefaults.standard.string(forKey: "userToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userToken")
            checkSession()
        }
    }
    
    var status: AuthState = .noAuthenticated
    
    private init() {
        checkSession()
    }
    
    func checkSession() {
        if let _ = token {
            status = .authenticated
        } else {
            status = .noAuthenticated
        }
    }
    
    func login(token: String) {
        self.token = token
        status = .authenticated
    }
    
    func logout() {
        token = nil
        status = .noAuthenticated
    }
}
