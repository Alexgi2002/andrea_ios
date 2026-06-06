//
//  CustomResponse.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

struct CustomResponse<T: Decodable>: Decodable {
//    let statusCode: Int
    let message: String?
    let data: T?
    let error: CustomError?
    
//    var isSuccess: Bool {
//        return statusCode >= 200 && statusCode < 300
//    }
    
    var isError: Bool {
        if let _ = error { return true }
        return false
    }
}

struct CustomError : Decodable {
    let message: String
}

