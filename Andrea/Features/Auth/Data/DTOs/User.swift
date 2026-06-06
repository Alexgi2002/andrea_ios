//
//  User.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

import Foundation

struct UserDTO: Codable, Identifiable {
    let id :                Int
    let username :          String
    let name :              String
    let email :             String
    let phone :             String
    let description :       String
    let country :           String
    let birthdate :         Date
    let showBirthdate :     Bool
    let online :            Bool
    let lastSeen :          Date
    let showLastSeen :      Bool
    let lastLogin :         Date
    let genderIdentity :    Int
    let genderPreference :  Int
    let whatAreLookingFor : String
    let lastLocation :      String?
    let showLastLocation :  Bool
    let active :            Bool
    let verified :          Bool
    let popularity :        String
    let rangeAgeMin :       Int
    let rangeAgeMax :       Int
    let role :              String
    let createdAt :         Date
    let images :            [FileDTO]
    let preferences :       [UserPreferencesDTO]
    
    var age : Int {
        Calendar.current.dateComponents([.year], from: birthdate, to: Date()).year!
    }
}

struct UserPreferencesDTO: Codable {
    let preference : PreferenceDTO
    let show       : Bool
}

struct PreferenceDTO: Codable{
    let id :         Int
    let text :       String
    let categoryId : Int
}
