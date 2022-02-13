//
//  NetworkMonitor.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 13.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation
import Network

final class NetworkMonitor {
    
    //Singleton for work with network
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    public private(set) var connectionType: ConnectionType = .unknown
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    public func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else {
            connectionType = .unknown
        }
    }
}

enum ConnectionType {
    case wifi
    case cellular
    case unknown
}
