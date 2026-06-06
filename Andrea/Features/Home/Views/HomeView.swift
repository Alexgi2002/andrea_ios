//
//  ContentView.swift
//  Andrea
//
//  Created by AlexGI on 05/06/2026.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedTab = 0

    var body: some View {
        @State var viewModel: HomeViewModel = HomeViewModel()
        
        NavigationStack {
            TabView(selection: $selectedTab) {
                FeedView().tabItem{ Label("Inicio", systemImage: "flame.fill") }.tag(0)
                WhispersView().tabItem{ Label("Susurros", systemImage: "microphone.fill") }.tag(1)
                CommunityView().tabItem{ Label("Comunidades", systemImage: "person.3.fill") }.tag(2)
                ChatView().tabItem{ Label("Chat", systemImage: "message.fill") }.tag(3)
                ProfileView().tabItem{ Label("Perfil", systemImage: "person.fill") }.tag(4)
            }
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
            .navigationTitle(selectedTab == 4 ? "" : "Andrea")
            .toolbar {
                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                }
//                ToolbarItem {
                    Button(action: {}) {
                        Label("Buscar", systemImage: "magnifyingglass")
                    }
                    Button(action: {}) {
                        Label("Notificaciones", systemImage: "bell")
                    }
//                }
            }
            .environment(viewModel)
            .task {
                await viewModel.getData()
            }
        }
    }
}

#Preview {
    HomeView()
}
