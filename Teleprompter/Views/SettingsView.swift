//
//  SettingsView.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/11/27.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var defaults = DefaultsManager.shared
    
    var body: some View {
        NavigationStack {
            List {
                Button {
                    dismiss()
                    defaults.isFirstStartUp = true
                } label: {
                    Label("显示启动页", systemImage: "text.page")
                }
                Link(destination: URL(string: "https://github.com/MrSouthWall/Teleprompter")!) {
                    HStack {
                        Text("关于：本 App 为免费开源项目")
                        Spacer()
                        Image(systemName: "safari")
                            .foregroundStyle(.secondary)
                    }
                }
                Link(destination: URL(string: "https://github.com/MrSouthWall")!) {
                    HStack {
                        Text("作者：MrSouthWall")
                        Spacer()
                        Image(systemName: "safari")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("设置")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("完成") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
