//
//  QuotesView.swift
//  QuotesAppSwiftUI
//
//  Created by Inder Jagdeo on 23/07/24.
//

import SwiftUI
import Combine

struct QuotesView: View {
    @StateObject private var viewModel = QuotesViewModel()
    @State private var selectedQuote: Quote?
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Quotes")
                .navigationDestination(item: $selectedQuote){ quote in
                    QuoteView(viewModel: QuoteViewModel(quote: quote))
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

private extension QuotesView {
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .notLoaded, .loading:
            ProgressView()
        case .loaded(let quotes):
            ListView(quotes: quotes, selectedQuote: $selectedQuote)
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

extension QuotesView {
    struct ListView: View {
        var quotes: [Quote]
        @Binding var selectedQuote: Quote?
        
        var body: some View {
            List(quotes) { quote in
                VStack(alignment: .leading) {
                    Text("\"\(quote.content)\"")
                        .font(.body)
                        .padding(.bottom, 2)
                    Text("- \(quote.author)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .onTapGesture {
                    selectedQuote = quote
                    print("Quote: ", quote);
                }
            }
        }
    }
}


#Preview {
    QuotesView()
}

