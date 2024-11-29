//
//  OrientationManagerViewController.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/11/29.
//

import Foundation
import UIKit

// 服务于强制设定手机方向

/// 方向管理器视图控制器
class OrientationManagerViewController: UIViewController {
    
    static private(set) var orientations = UIInterfaceOrientationMask.all
    static private var rootHasReplaced = false
    
    static func setOrientations(_ new: UIInterfaceOrientationMask) {
        guard let keyWindow = UIApplication.shared.keyWindowIfExist, let currentRootVC = keyWindow.rootViewController else { return }
        
        if Self.rootHasReplaced {
            Self.orientations = new
            
            // 立即刷新屏幕旋转方向限制，下同
            currentRootVC.setNeedsUpdateOfSupportedInterfaceOrientations()
        }else{
            DispatchQueue.main.async {
                let newVC = OrientationManagerViewController()
                keyWindow.rootViewController = newVC
                newVC.addChild(currentRootVC)
                newVC.view.addSubview(currentRootVC.view)
                currentRootVC.didMove(toParent: newVC)
                Self.rootHasReplaced = true
                Self.orientations = new
                newVC.setNeedsUpdateOfSupportedInterfaceOrientations()
                
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        Self.orientations
    }
}
