//
//  auth.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

struct LoginDTO: Codable {
    let identifier: String
    let password: String
    let fcm_token: String?
    let device_name: String
}

struct AuthResponse: Codable {
    let token : String
    let user : UserDTO
}
