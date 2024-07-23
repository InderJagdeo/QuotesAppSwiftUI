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
    @State private var subscriptions = Set<AnyCancellable>()
    
    var body: some View {
        content
        .task {
            viewModel.transform(input: .load)
        }
    }
}

private extension QuoteView {
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .notLoaded, .loading:
            ProgressView()
        case .loaded(let quote):
            VStack {
                Text(quote?.content ?? "")
                    .font(.largeTitle)
                    .padding() 
                Text(quote?.author ?? "")
                    .font(.title2)
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
    QuoteView(viewModel: QuoteViewModel(quote: nil))
}
