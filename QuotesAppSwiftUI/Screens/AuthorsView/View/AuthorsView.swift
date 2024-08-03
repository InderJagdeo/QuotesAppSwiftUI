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
    @State private var selectedAuthor: Author?
    
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
        case .notLoaded:
            ProgressView()
        case .loaded(let authors):
            ListView(authors: authors, selectedAuthor: $selectedAuthor)
                .listRowSpacing(16.0)
                .scrollIndicators(.hidden)
                .listStyle(PlainListStyle())
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

private extension AuthorsView {
    struct ListView: View {
        var authors: [Author]
        @Binding var selectedAuthor: Author?
        
        var body: some View {
            List(authors) { author in
                AuthorCellView(author: author)
                    .padding(.horizontal, 16.0)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .onTapGesture {
                        selectedAuthor = author
                        print(author)
                    }
            }
        }
    }
    
    struct AuthorCellView: View {
        var author: Author
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text("\"\(author.name)\"")
                    .font(.body)
                Text("- \(author.description)")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .background(Color("mercury"))
            .clipShape(RoundedRectangle(cornerRadius: 16.0))
        }
    }

}

#Preview {
    AuthorsView()
}

