//
//  WatchSessionManager.swift
//  WatchTeleprompter Watch App
//
//  Created by MrSouthWall on 2024/12/2.
//

import Foundation
import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {    
    static let shared = WatchSessionManager()
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    // 发送消息到 iPhone
    func sendScrollCommand(_ isPlaying: Bool) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(["play": isPlaying], replyHandler: nil, errorHandler: nil)
        }
    }
    // 发送方向消息到 iPhone
    func sendScrollDirection(_ direction: Bool) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(["direction": direction], replyHandler: nil, errorHandler: nil)
        }
    }
    
    // MARK: - WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        if let error = error {
            print("WCSession activation failed with error: \(error.localizedDescription)")
        } else if activationState == .activated {
            print("WCSession successfully activated.")
        }
    }
}
