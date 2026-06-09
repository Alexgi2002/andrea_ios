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

struct RegisterDTO: Codable {
    let name : String
    let email : String
    let username : String
    let phone : String
    let genderIdentity : Int
    let genderPreference : Int
    let birthdate : Int64
    let password : String
    let country : String?
}

struct AuthResponse: Codable {
    let token : String?
    let user : UserDTO
}
