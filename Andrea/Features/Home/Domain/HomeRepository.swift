//
//  HomeRepository.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

protocol HomeRepository {
    func feed() async throws -> [UserDTO]
    func me() async throws -> UserDTO
}
