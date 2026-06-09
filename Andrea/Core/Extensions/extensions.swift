//
//  extensios.swift
//  Andrea
//
//  Created by AlexGI on 09/06/2026.
//
import Foundation

extension Date {
    var millisecondsSinceEpoch: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}
