//
//  PopUpController.swift
//  Teleprompter
//
//  Created by MrSouthWall on 2024/11/28.
//

import SwiftUI

struct PopUpController<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
                .shadow(radius: 5.0)
            
            content
        }
        .frame(maxWidth: 300, maxHeight: 40)
    }
}

#Preview {
    PopUpController() {
        Text("Test")
    }
}
