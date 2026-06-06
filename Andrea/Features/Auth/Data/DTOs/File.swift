//
//  File.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

import Foundation

struct FileDTO: Codable {
    let id         : Int
    let name       : String
    let path       : String
    let type       : String
    let createdAt  : Date
    let userId     : Int?
    let messageId  : Int?
    let orderIndex : Int
}
