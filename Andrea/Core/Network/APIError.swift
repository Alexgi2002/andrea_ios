//
//  APIError.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//
import Foundation

enum APIError: LocalizedError {
    case backendError(message: String)
    case noData
    
    var errorDescription: String? {
        switch self {
        case .backendError(let message): return message
        case .noData: return "El servidor no devolvió datos."
        }
    }
}
