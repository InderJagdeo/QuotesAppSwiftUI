//
//  AuthorsView.swift
//  QuotesAppSwiftUI
//
//  Created by Inder Jagdeo on 23/07/24.
//

import SwiftUI
import Combine

struct AuthorsView: View {
    
    @StateObject private var viewModel = AuthorsViewModel()
    @State private var selectedAuthor: Authors?
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Authors")
                .navigationDestination(item: $selectedAuthor){ author in
                    AuthorDetailView(viewModel: AuthorDetailViewModel(authorId: author.id))
                }
                .task {
                    viewModel.transform(input: .load)
                }
                .refreshable {
                    viewModel.transform(input: .refresh)
                }
        }
    }
}

private extension AuthorsView {
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .notLoaded, .loading:
            ProgressView()
        case .loaded(let authors):
            ListView(authors: authors, selectedAuthor: $selectedAuthor)
        case .noData:
            ContentUnavailableView(
                "No Data Available",
                systemImage: "list.bullet.rectangle",
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

extension AuthorsView {
    struct ListView: View {
        var authors: [Authors]
        @Binding var selectedAuthor: Authors?
        
        var body: some View {
            List(authors) { author in
                VStack(alignment: .leading) {
                    Text("\"\(author.name)\"")
                        .font(.body)
                        .padding(.bottom, 2)
                    Text("- \(author.description)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .onTapGesture {
                    selectedAuthor = author
                    print(author)
                }
            }
        }
    }
}

#Preview {
    AuthorsView()
}

