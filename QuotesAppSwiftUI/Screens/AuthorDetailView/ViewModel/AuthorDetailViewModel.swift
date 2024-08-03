//
//  AuthorDetailViewModel.swift
//  Quotes
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation
import Combine

class AuthorDetailViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published private(set) var author: AuthorDetail?
    @Published private(set) var state: Output = .notLoaded
    
    private var subscriptions = Set<AnyCancellable>()
    private let networkManager: NetworkManagerProtocol
    
    // MARK: - Enumerations
    enum Input: Equatable {
        case load(String)
    }
    
    enum Output {
        case notLoaded
        case noData
        case error(Error)
        case loaded(AuthorDetail?)
    }
    
    // MARK: - Initializer
    init(authorId: String, networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
        self.requestAuthorDetail(authorId: authorId)
    }
    
    // MARK: - User Defined Methods
    internal func transform(input: Input) {
        switch input {
        case .load(let authorId):
            requestAuthorDetail(authorId: authorId)
        }
    }
    
    // MARK: - Web Requests
    private func requestAuthorDetail(authorId: String) {
        let request = AuthorDetailRequest(id: authorId)
        
        let valueHandler: (AuthorDetail) -> Void = { [weak self] author in
            self?.author = author
        }
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.state = .error(error)
            case .finished:
                self?.state = self?.author == nil ? .noData : .loaded(self?.author)
            }
        }
        
        networkManager.request(request)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &subscriptions)
    }
}

