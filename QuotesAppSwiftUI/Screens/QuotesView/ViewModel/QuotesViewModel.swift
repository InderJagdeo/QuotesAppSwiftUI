//
//  QuotesListViewModel.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation
import Combine

class QuotesViewModel: ObservableObject {
    // MARK: - Properties
    @Published private(set) var quotes: QuotesData?
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
        case loaded(quotes: [Quote]) // You might want to pass the fetched data
    }
    
    // MARK: - Initializer
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: - User Defined Methods
    internal func transform(input: Input) {
        switch input {
        case .load, .refresh:
            requestRandomQuote()
        }
    }
    
    // MARK: - Web Requests
    private func requestRandomQuote() {
        let request = QuotesRequest()
        
        let valueHandler: (QuotesData) -> Void = { [weak self] quotes in
            self?.quotes = quotes
        }
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.state = .error(error: error)
            case .finished:
                self?.state =  self?.quotes?.totalCount == 0 ? .noData :  .loaded(quotes: self?.quotes?.results ?? [])
            }
        }
        
        networkManager.request(request)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &subscriptions)
    }
}
