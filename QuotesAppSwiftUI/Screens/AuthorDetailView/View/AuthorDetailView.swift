//
//  AuthorDetailView.swift
//  QuotesAppSwiftUI
//
//  Created by Inder Jagdeo on 23/07/24.
//

import SwiftUI
import Combine

struct AuthorDetailView: View {
    
    @StateObject var viewModel: AuthorDetailViewModel
    @State private var subscriptions = Set<AnyCancellable>()
    
    var body: some View {
        NavigationStack {
            content
            .navigationTitle("Auther Detail")
            .navigationBarTitleDisplayMode(.inline)
        }
 
    }
}

extension AuthorDetailView {
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .notLoaded, .loading:
            ProgressView()
        case .loaded(let author):
            VStack {
                Text(author?.name ?? "")
                    .font(.largeTitle)
                    .padding()
                Text(author?.description ?? "").padding()
                Text(author?.bio ?? "")
                    .padding()
            }
        case .noData:
            ContentUnavailableView(
                "All rockets are on a mission in outer space 🚀",
                systemImage: "sparkles",
                description: Text("Please try it later")
            )
        case .error(let error):
            ContentUnavailableView(
                "An Error Occured",
                systemImage: "exclamationmark.triangle",
                description: Text("Error: \(error.localizedDescription)")
            )
        }
    }
}

#Preview {
    let viewModel = AuthorDetailViewModel(authorId: "76ISAUD3P5")
    return (AuthorDetailView(viewModel: viewModel))
}
