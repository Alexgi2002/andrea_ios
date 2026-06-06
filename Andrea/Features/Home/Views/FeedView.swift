//
//  FeedView.swift
//  Andrea
//
//  Created by AlexGI on 06/06/2026.
//

import SwiftUI

struct FeedView: View {
    @State private var viewModel: HomeViewModel = HomeViewModel()
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            }
            else if viewModel.data.isEmpty {
                // Vista intermedia si te quedas sin candidatos (Soporte Offline / Fin del feed)
                noMoreCandidatesView
            } else {
                ForEach(viewModel.data) { item in
                    CardSwipe(data: item, onSwipe: {swipe,id in
                        viewModel.data.remove(at: viewModel.data.firstIndex(where: { $0.id == id })!)
                    })
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
    
    private var noMoreCandidatesView: some View {
            VStack(spacing: 12) {
                Image(systemName: "sparkles")
                    .font(.system(size: 50))
                    .foregroundColor(.appPrimary)
                Text("No hay más personas cerca de ti")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
}

#Preview {
    FeedView()
}
