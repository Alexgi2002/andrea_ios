//
//  AndreaApp.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//

import SwiftUI
import SwiftData

@main
struct AndreaApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//    
    @State private var authManager = AuthManager.shared

    var body: some Scene {
        WindowGroup {
            Group {
                switch authManager.status {
                    case .authenticated:
                        HomeView()
                    case .noAuthenticated:
                        LoginView()
                }
            }
            .environment(authManager)
            .preferredColorScheme(.dark)
        }
//        .modelContainer(sharedModelContainer)
    }
}
