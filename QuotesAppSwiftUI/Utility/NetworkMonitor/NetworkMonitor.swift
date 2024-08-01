//
//  NetworkMonitor.swift
//  NetworkLayer
//
//  Created by Inder Jagdeo on 23/07/24.
//

import Foundation
import Network
import Combine

final class NetworkMonitor: ObservableObject {
    
    // MARK: - Properties
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private(set) var isCellular: Bool = true
    private(set) var status = NWPath.Status.requiresConnection
    
    @Published private(set) var isConnectd: Bool = false
    
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    // MARK: - Private Initializer
    private init() {}
    
    deinit {
        monitor.cancel()
    }
}

extension NetworkMonitor {
    // MARK: - Monitor Network Connection
    
    public func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.status = path.status
                self?.isCellular = path.isExpensive
                self?.isConnectd = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
}


