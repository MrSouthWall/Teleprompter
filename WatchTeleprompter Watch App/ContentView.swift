//
//  ContentView.swift
//  WatchTeleprompter Watch App
//
//  Created by MrSouthWall on 2024/12/2.
//

import SwiftUI

struct ContentView: View {
    @State private var sessionManager = WatchSessionManager.shared
    
    @State private var isPlaying = false
    @State private var direction = false
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab {
                    playButton()
                }
//                Tab {
//                    controlButton()
//                }
            }
//            .navigationTitle("提词器")
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button {
//                        direction.toggle()
//                        
//                        if direction {
//                            sessionManager.sendScrollDirection(true)
//                        } else {
//                            sessionManager.sendScrollDirection(false)
//                        }
//                    } label: {
//                        if direction {
//                            Image(systemName: "chevron.up.2")
//                        } else {
//                            Image(systemName: "chevron.down.2")
//                        }
//                    }
//                }
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        
//                    } label: {
//                        Text("待定")
//                    }
//                }
//            }
        }
    }
    
    /// 播放按钮
    private func playButton() -> some View {
        ZStack {
            Button {
                isPlaying.toggle()
                
                if isPlaying {
                    sessionManager.sendScrollCommand(true)
                    WKInterfaceDevice.current().play(.start)
                } else {
                    sessionManager.sendScrollCommand(false)
                    WKInterfaceDevice.current().play(.stop)
                }
            } label: {
                ZStack {
                    Circle()
                        .foregroundStyle(.quaternary)
                    
                    if isPlaying {
                        Image(systemName: "pause.fill")
                    } else {
                        Image(systemName: "play.fill")
                    }
                }
                .font(.largeTitle)
            }
            .buttonStyle(.plain)
        }
    }
    /// 控制按钮
    private func controlButton() -> some View {
        VStack {
//            HStack {
//                Button {
//                    
//                } label: {
//                    ZStack {
//                        Circle().foregroundStyle(.red)
//                        Text("1")
//                    }
//                }
//                .buttonStyle(.plain)
//                Button {
//                    
//                } label: {
//                    ZStack {
//                        Circle().foregroundStyle(.red)
//                        Text("1")
//                    }
//                }
//                .buttonStyle(.plain)
//            }
//            HStack {
//                Button {
//                    
//                } label: {
//                    ZStack {
//                        Circle().foregroundStyle(.red)
//                        Text("1")
//                    }
//                }
//                .buttonStyle(.plain)
//                Button {
//                    
//                } label: {
//                    ZStack {
//                        Circle().foregroundStyle(.red)
//                        Text("1")
//                    }
//                }
//                .buttonStyle(.plain)
//            }
        }
    }
}

#Preview {
    ContentView()
}
