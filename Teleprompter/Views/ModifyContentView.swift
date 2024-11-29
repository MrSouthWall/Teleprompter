//
//  ModifyContentView.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/11/29.
//

import SwiftUI

struct ModifyContentView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var item: Item = Item(title: "", content: "")
    
    var body: some View {
        NavigationStack {
            Form {
                Section("输入标题") {
                    TextField("", text: $item.title)
                }
                Section("输入内容") {
                    TextEditor(text: $item.content)
                        .frame(minHeight: 400)
                }
            }
            .navigationTitle("修改内容")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("取消")
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button("保存") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button {
                            UIApplication.shared.keyWindowIfExist?.endEditing(true)
                        } label: {
                            Text("完成")
                        }
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ModifyContentView()
}
