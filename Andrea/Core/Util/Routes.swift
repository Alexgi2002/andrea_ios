//
//  Routes.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

import SwiftUI

enum AppDestination: Hashable {
    case register
    case login
    case home
    //    case chatDetail(roomID: String)
}


struct DestinationRouter {
    @ViewBuilder
    static func view(for destination: AppDestination) -> some View {
        switch destination {
        case .login:
            LoginView()
        case .register:
            RegisterView()
        case .home:
            HomeView()
            //        case .chatDetail(let roomID):
            //            Text("Chat privado: \(roomID)")
            
        }
    }
}
