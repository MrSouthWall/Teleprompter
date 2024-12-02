//
//  WatchSessionManager.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/12/2.
//

import Foundation
import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchSessionManager()
    
    private override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    @Published var isPlaying = false // 控制滚动的变量
    @Published var direction = true // 控制滚动的方向，true 为正向，false 为反向
    
    // 接收来自 Watch 的消息
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            if let playCommand = message["play"] as? Bool {
                print("iPhone 端 WatchSessionManager 接收到：\(playCommand.description)")
                self.isPlaying = playCommand
            }
            if let directionCommand = message["direction"] as? Bool {
                self.direction = directionCommand
            }
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
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("WCSession has become inactive.")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("WCSession has been deactivated.")
    }
}
