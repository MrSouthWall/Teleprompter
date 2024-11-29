//
//  Item.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/11/27.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var title: String
    var content: String
    var deleted: Bool
    
    // 题词播放设置
    
    /// 滚动速度
    var scrollSpeed: Double = 50
    /// 是否横屏
    var isRotating: Bool = true
    /// 字体大小
    var fontSize: CGFloat = 50
    /// 是否镜像
    var isMirror: Bool = false
    
    init(title: String, content: String) {
        self.timestamp = .now
        self.title = title
        self.content = content
        self.deleted = false
    }
}
