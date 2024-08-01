//
//  QuoteViewModel.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation
import Combine

class QuoteViewModel: ObservableObject {
    // MARK: - Properties
    @Published private(set) var quote: Quote?
    @Published private(set) var state: Output = .notLoaded
    
    private var subscriptions = Set<AnyCancellable>()
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Enumerations
    enum Input: Equatable {
        case load
        case refresh
    }
    
    enum Output {
        case notLoaded
        case loading
        case noData // Indicates successful fetch but no data
        case error(error: Error) // You might want to pass an error message
        case loaded(quotes: Quote?) // You might want to pass the fetched data
    }
    
    // MARK: - Initializer
    init(quote: Quote? = nil, networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.quote = quote
        self.networkManager = networkManager
        
        if (quote != nil) {
            self.state = .loaded(quotes: quote)
        } 
    }
    
    // MARK: - User Defined Methods
    internal func transform(input: Input) {
        switch input {
        case .load:
            guard quote == nil else { return }
            self.requestRandomQuote()
        case .refresh:
            self.requestRandomQuote()
        }
    }
    
    // MARK: - Web Requests
    private func requestRandomQuote() {
        let request = RandomQuoteRequest()
        
        let valueHandler: (Quote) -> Void = { [weak self] quote in
            self?.quote = quote
        }
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.state = .error(error: error)
            case .finished:
                self?.state = .loaded(quotes: self?.quote)
            }
        }
        
        networkManager.request(request)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &subscriptions)
    }
}
