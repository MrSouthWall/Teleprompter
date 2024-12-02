//
//  ContentView.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/11/27.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @StateObject private var defaults = DefaultsManager.shared
    
    /// 是否显示新增提词
    @State private var isShowAddNewItemView = false
    @State private var isShowSettingsView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        ItemContentView(item: item)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(item.title)
                            Text(item.content)
                                .font(.footnote)
                                .foregroundStyle(.secondary)
                                .lineLimit(2)
                        }
                    }
                    
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("提词器")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("添加文案", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("设置", systemImage: "gear") {
                        isShowSettingsView.toggle()
                    }
                }
            }
            .sheet(isPresented: $isShowAddNewItemView) {
                AddNewItemView()
                    .interactiveDismissDisabled(true)
            }
            .sheet(isPresented: $isShowSettingsView) {
                SettingsView()
            }
            .fullScreenCover(isPresented: $defaults.isFirstStartUp) {
                StartUpView()
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            isShowAddNewItemView.toggle()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
