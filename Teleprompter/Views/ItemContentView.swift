//
//  ItemContentView.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/11/27.
//

import SwiftUI

enum StyleSettingOptions {
    case scrollSpeed
    case fontSize
}

struct ItemContentView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var item: Item
    
    /// 是否播放
    @State private var isPlaying: Bool = false
    @State private var timer: Timer? = nil
    
    /// 绑定 ScrollView 的位置
    @State private var position: ScrollPosition = ScrollPosition(y: 0)
    /// 当前屏幕位置
    @State private var currentOffsetY: CGFloat = 0
    
    /// 是否显示样式设置面板
    @State private var isShowStyleSettingsPanel: Bool = false
    /// 悬浮样式设置选项
    @State private var styleSettingOptions: StyleSettingOptions? = nil
    /// 是否显示编辑文字视图
    @State private var isShowEditContentView: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            ScrollView {
                Color.clear
                    .frame(height: 100)
                
                Text(item.content)
                    .foregroundStyle(.white)
                    .font(.system(size: item.fontSize))
                
                Color.clear
                    .frame(height: 100)
            }
            .ignoresSafeArea(edges: .vertical)
            .scaleEffect(y: item.isMirror ? -1 : 1 ,anchor: .center)
            /* 一个奇怪的 Bug
             不知道 .scaleEffect 修改器和 .onScrollGeometryChange 有什么冲突，只要我设置为 Y 轴反转，在开始滚动时，ScrollView 的位置就会卡一下。
             所以我的解决方案就是先 .rotationEffect 旋转 180 度，然后再 X 轴反转。
             
             Fix: 似乎发现了 Bug 产生的原因，是因为没有忽略安全边距，如果去除 .ignoresSafeArea() 问题则会重现
             */
            .scrollPosition($position)
            .onTapGesture(perform: switchPlayStatus)
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                geometry.contentOffset.y
            } action: { oldValue, newValue in
                if oldValue != newValue {
                    currentOffsetY = newValue
                    print("position Y (old): \(oldValue) | position Y (new): \(newValue)")
                }
            }
            
        }
        .navigationBarBackButtonHidden() // 隐藏 NavigationBar 组件
        // 实时读取当前 ScrollView Y 轴偏移
        .onChange(of: item.isRotating) { oldValue, newValue in
            if newValue {
                OrientationManagerViewController.setOrientations(.landscapeRight)
            } else {
                OrientationManagerViewController.setOrientations(.portrait)
            }
        }
        // 编辑面板
        .overlay(alignment: .trailing) {
            ZStack {
                Color.clear
                
                Text("一些设置")
            }
            .background(.ultraThinMaterial)
            .frame(maxWidth: 300)
            .offset(x: isShowStyleSettingsPanel ? 0 : 400)
            .animation(.smooth, value: isShowStyleSettingsPanel)
        }
        // 控制栏
        .overlay(alignment: .top) {
            controlBar()
        }
        // 浮悬控制条
        .overlay(alignment: .top) {
            if let styleSettingOptions = styleSettingOptions {
                switch styleSettingOptions {
                case .scrollSpeed:
                    PopUpController {
                        HStack(spacing: 10) {
                            Text("速度")
                            Slider(value: $item.scrollSpeed, in: 20...100, step: 1)
                            Text(String(format: "%.0f", item.scrollSpeed))
                                .frame(minWidth: 28)
                        }
                        .font(.footnote.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                    }
                    .padding(.top, 60)
                case .fontSize:
                    PopUpController {
                        HStack(spacing: 10) {
                            Text("大小")
                            Slider(value: $item.fontSize, in: 20...100, step: 1)
                            Text(String(format: "%.0f", item.fontSize))
                                .frame(minWidth: 28)
                        }
                        .font(.footnote.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                    }
                    .padding(.top, 60)
                }
            }
        }
        // 屏幕中间的播放按钮
        .overlay {
            Button {
                switchPlayStatus()
            } label: {
                Image(systemName: "play.circle")
                    .font(.system(size: 80))
                    .fontWeight(.light)
            }
            .opacity(isPlaying ? 0 : 0.75)
            .animation(.smooth(duration: 0.2), value: isPlaying)
        }
        .sheet(isPresented: $isShowEditContentView) {
            ModifyContentView(item: item)
                .colorScheme(.dark)
        }
    }
    
    /// 控制栏
    private func controlBar() -> some View {
        HStack(spacing: 20) {
            // 返回按钮
            Button {
                isPlaying = false
                item.isRotating = false
                dismiss()
            } label: {
                Image(systemName: "arrow.left")
            }
            
            Spacer()
            // 旋转按钮
            Button {
                item.isRotating.toggle()
            } label: {
                Image(systemName: "rectangle.portrait.rotate")
            }
            // 镜像按钮
            Button {
                withAnimation {
                    item.isMirror.toggle()
                }
            } label: {
                Image(systemName: "trapezoid.and.line.vertical")
            }
            // 速度按钮
            Button {
                withAnimation {
                    if styleSettingOptions != .scrollSpeed {
                        styleSettingOptions = .scrollSpeed
                    } else {
                        styleSettingOptions = nil
                    }
                }
            } label: {
                Image(systemName: "gauge.with.dots.needle.bottom.0percent")
            }
            // 文字大小按钮
            Button {
                withAnimation {
                    if styleSettingOptions != .fontSize {
                        styleSettingOptions = .fontSize
                    } else {
                        styleSettingOptions = nil
                    }
                }
            } label: {
                Image(systemName: "textformat.size")
            }
            // 编辑文字按钮
            Button {
                isShowEditContentView = true
            } label: {
                Image(systemName: "square.and.pencil")
            }
            // 编辑按钮
//            Button {
//                isShowStyleSettingsPanel.toggle()
//                print(isShowStyleSettingsPanel)
//            } label: {
//                Image(systemName: "slider.horizontal.3")
//            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(.ultraThinMaterial)
        .opacity(isPlaying ? 0 : 1)
        .animation(.smooth, value: isPlaying)
    }
    
    /// 切换播放状态
    private func switchPlayStatus() {
        withAnimation {
            styleSettingOptions = nil
        }
        isPlaying.toggle()
        
        if isPlaying {
            print("开始滚动")
            var y = currentOffsetY
            let i = 0.001
            timer = Timer.scheduledTimer(withTimeInterval: i, repeats: true) { _ in
                y += item.scrollSpeed * i
                position.scrollTo(y: y)
                print("currentOffsetY: \(currentOffsetY), y: \(y)")
            }
        } else {
            print("结束滚动")
            timer?.invalidate()
            timer = nil
        }
    }
}

#Preview {
    let content: String = """
有人说，生活是柴米油盐的重复，可我觉得，生活的美好藏在细微的瞬间里。
早晨，阳光穿过窗帘的缝隙，洒在你的枕头上，空气中飘着一缕咖啡的香气，这就是一天的好开始。忙碌中偶然抬头，看到天边一抹橙红的晚霞；下班路上遇见一只歪头看你的流浪猫；收到朋友一句简单的“记得好好吃饭”……这些不起眼的小事，却像调味剂，为平凡的日子增添了温暖。
“小确幸”是突如其来的满足感，是你为自己点的小甜点，是深夜加班时有人悄悄递上的一杯热水，是雨后空气中那淡淡的泥土香气。这些不起眼的细节，拼凑成生活的底色，提醒我们：忙碌中也要记得感受幸福。
也许你正为了梦想而奔波，为了生活而奋斗，有时甚至觉得疲惫不堪。但生活的意义，从来不在于大场面，而是那些被忽略的微光。用心去感受，去记录，你会发现，幸福一直在你身边。
所以，不妨在今天的忙碌里，停下来想一想：你的“小确幸”是什么呢？是刚才温暖的阳光？是此刻吹过耳边的微风？还是屏幕前的一段文字，让你忽然放松了嘴角？生活从不缺乏美好，缺的只是发现的眼睛。
每一天，都值得被用心对待。去寻找那些小确幸吧，它们会让你记住：生活从未辜负爱它的人。
"""
    ItemContentView(item: Item(title: "生活的小确幸", content: content))
}
