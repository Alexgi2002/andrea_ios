//
//  Item.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
