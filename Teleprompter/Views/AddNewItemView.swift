//
//  AddNewItemView.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/11/27.
//

import SwiftUI
import SwiftData

struct AddNewItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("输入标题") {
                    TextField("", text: $title)
                }
                Section("输入内容") {
                    TextEditor(text: $content)
                        .frame(minHeight: 400)
                }
            }
            .navigationTitle("新文案")
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
                    Button("添加") {
                        addNewItem()
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
    
    /// 添加新文案方法
    private func addNewItem() {
        let newItem = Item(title: title, content: content)
        modelContext.insert(newItem)
    }
}

#Preview {
    AddNewItemView()
}
