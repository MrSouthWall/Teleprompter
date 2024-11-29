//
//  DefaultsManager.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/11/27.
//

import Foundation
import SwiftUI

class DefaultsManager: ObservableObject {
    /// Defaults 的单例对象
    static let shared = DefaultsManager()
    /// 私有化初始化器，防止从外部创建对象
    private init() { }
    
    /// 滚动速度
    @AppStorage("speed") var speed: Double = 100
    /// 是否镜像
    @AppStorage("isMirroring") var isMirroring: Bool = false
    /// 字体大小
    @AppStorage("fontSize") var fontSize: Int = 50
}
