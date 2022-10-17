//
//  ReachabilityHandler.swift
//  Pokedex
//
//  Created by Eliano Corallo on 16/10/22.
//

import Foundation
import Reachability

class ReachabilityHandler: NSObject {
    var reachability: Reachability!
    static let sharedInstance: ReachabilityHandler = ReachabilityHandler()
    
    override init() {
        super.init()
        // Initialise reachability
        reachability = try? Reachability()
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    @objc func networkStatusChanged(_ notification: Notification) {
        // Do something globally here!
    }
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (ReachabilityHandler.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }
    
    // Network is reachable
    static func isReachable(completed: @escaping (ReachabilityHandler) -> Void) {
        if (ReachabilityHandler.sharedInstance.reachability).connection != .unavailable {
            completed(ReachabilityHandler.sharedInstance)
        }
    }
    // Network is unreachable
    static func isUnreachable(completed: @escaping (ReachabilityHandler) -> Void) {
        if (ReachabilityHandler.sharedInstance.reachability).connection == .unavailable {
            completed(ReachabilityHandler.sharedInstance)
        }
    }
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (ReachabilityHandler) -> Void) {
        if (ReachabilityHandler.sharedInstance.reachability).connection == .cellular {
            completed(ReachabilityHandler.sharedInstance)
        }
    }
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (ReachabilityHandler) -> Void) {
        if (ReachabilityHandler.sharedInstance.reachability).connection == .wifi {
            completed(ReachabilityHandler.sharedInstance)
        }
    }
    
}
