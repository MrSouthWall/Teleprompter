//
//  Extension.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/11/28.
//

import Foundation
import UIKit

// 服务于强制设定手机方向
extension UIApplication {
    var keyWindowIfExist: UIWindow? {
        connectedScenes
            .filter { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive}
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .filter { $0.isKeyWindow }
            .first
    }
}
