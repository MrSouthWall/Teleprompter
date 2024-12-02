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
            
            Spacer()
            
            Text("欢迎使用“提词器”")
                .font(.title.bold())
                .padding(.vertical, 30)
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "checkmark.applewatch")
                        .font(.title)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: 50)
                    Text("使用您的 Apple Watch 远程控制")
                        .font(.callout)
                }
                HStack {
                    Image(systemName: "xmark.triangle.circle.square.fill")
                        .font(.title)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: 50)
                    Text("iOS 原生风格设计，简洁、好用")
                        .font(.callout)
                }
                HStack {
                    Image(systemName: "paintbrush.pointed.fill")
                        .font(.title)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: 50)
                    Text("自定义功能，满足您的特殊需求")
                        .font(.callout)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 40)
            .padding(.vertical)
            
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
            
            Spacer()
        }
    }
}

#Preview {
    StartUpView()
}
