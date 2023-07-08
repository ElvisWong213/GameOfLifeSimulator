//
//  Menus.swift
//  GameOfLife
//
//  Created by Elvis on 04/07/2023.
//

import SwiftUI

struct Menus: Commands {
    @Binding var cellViewModel: Cell
    
    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button("Open") {
                cellViewModel.start = false
                let loadPanel = NSOpenPanel()
                loadPanel.canChooseDirectories = false
                loadPanel.allowsMultipleSelection = false
                loadPanel.allowedContentTypes = [.json]
                if loadPanel.runModal() == .OK {
                    guard let fileUrl = loadPanel.url else {
                        return
                    }
//                    cellViewModel.load(path: fileUrl)
                }
            }
        }
        CommandGroup(replacing: .saveItem) {
            Button("Save") {
                cellViewModel.start = false
                let savePanel = NSSavePanel()
                savePanel.allowedContentTypes = [.json]
                if savePanel.runModal() == .OK {
                    guard let fileUrl = savePanel.url else {
                        return
                    }
//                    cellViewModel.save(path: fileUrl)
                }
            }
            Button("Close") {
                NSApplication.shared.keyWindow?.close()
            }
            .keyboardShortcut("w")
        }
    }
}
