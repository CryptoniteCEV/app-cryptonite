//
//  NetworkCheck.swift
//  CryptoniteCev
//
//  Created by Alejandro García on 17/3/21.
//  Copyright © 2021 user177257. All rights reserved.
//

import Network

protocol NetworkCheckDelegate {
    func statusDidChange(status: NWPath.Status)
}

class NetworkCheck {

    private var monitor = NWPathMonitor()

    private static let _sharedInstance = NetworkCheck()

    var networkCheckDelegate: NetworkCheckDelegate?

    class func sharedInstance() -> NetworkCheck {
        return _sharedInstance
    }

    // Create only one instance of NetworkCheck
    private init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async(execute: {
                self.networkCheckDelegate?.statusDidChange(status: path.status)
            })
        }
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }

    func removeMonitoring() {
        monitor.cancel()
    }
}
