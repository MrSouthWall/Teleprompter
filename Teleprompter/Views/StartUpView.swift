//
//  StartUpView.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/12/2.
//

import SwiftUI

struct StartUpView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var defaults = DefaultsManager.shared
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(.teleprompterIconV1LightRound)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100)
                .shadow(color: .white.opacity(0.1), radius: 10)
            
            Text("欢迎使用“提词器”")
                .font(.title.bold())
                .padding(.top, 40)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top) {
                    Image(systemName: "checkmark.applewatch")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: 48)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("远程控制")
                            .bold()
                        Text("轻点您的 Apple Watch 即可远程控制滚动，无需额外设备，让演讲更加从容与自信。")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                HStack(alignment: .top) {
                    Image(systemName: "text.word.spacing")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: 48)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("专业提词")
                            .bold()
                        Text("无论是演讲、直播还是视频制作，精准滚动、可调速率，让您的每句话都恰到好处。")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                HStack(alignment: .top) {
                    Image(systemName: "xmark.triangle.circle.square")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: 48)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("极简设计")
                            .bold()
                        Text("专注文字展现，全局深色模式，与您的 iPhone 配合地恰到好处。")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 40)
            
            Spacer()
            
            // 继续按钮
            Button {
                defaults.isFirstStartUp = true
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundStyle(.quaternary)
                    .overlay(
                        Text("继续")
                    )
                    .frame(height: 50)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 60)
        }
    }
}

#Preview {
    StartUpView()
}
