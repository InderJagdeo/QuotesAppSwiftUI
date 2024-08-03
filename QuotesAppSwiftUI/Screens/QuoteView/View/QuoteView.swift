//
//  QuoteView.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import SwiftUI
import Combine

struct QuoteView: View {
    
    @StateObject var viewModel: QuoteViewModel
    @State private var isShareSheetPresented = false
    @State private var subscriptions = Set<AnyCancellable>()
    
    var body: some View {
        NavigationStack {
            content
                .task {
                    viewModel.transform(input: .load)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            viewModel.transform(input: .refresh)
                        }, label: {
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(.primary)
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            isShareSheetPresented = true
                        }, label: {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.primary)
                        })
                    }
                }
                .sheet(isPresented: $isShareSheetPresented, content: {
                    ActivityViewController(activityItems: [viewModel.quote?.content ?? ""])
                })
        }
    }
}

private extension QuoteView {
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .notLoaded:
            ProgressView()
        case .loaded(let randomQuote):
            if let quote = randomQuote {
                QuoteContentView(quote: quote)
                    .padding()
            }
        case .noData:
            ContentUnavailableView(
                "No Data Available",
                systemImage: "quote.bubble",
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

private extension QuoteView {
    struct QuoteContentView: View {
        var quote: Quote
        var body: some View {
            VStack(spacing: 16.0) {
                Text(quote.content)
                    .font(.title)
                Text("- \(quote.author)")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .background(Color("mercury"))
            .clipShape(RoundedRectangle(cornerRadius: 16.0))
        }
    }
}

#Preview {
    QuoteView(viewModel: QuoteViewModel(quote: nil))
}
