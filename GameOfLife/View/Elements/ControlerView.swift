//
//  BasicControlView.swift
//  GameOfLife
//
//  Created by Elvis on 24/06/2023.
//

import SwiftUI

struct ControlerView: View {
    @EnvironmentObject var cellViewModel: Cell
    
    var body: some View {
        VStack {
            HStack {
                Button("Clear") {
                    cellViewModel.clear()
                    cellViewModel.start = false
                }
                Button(cellViewModel.start ? "Stop" : "Start") {
                    cellViewModel.start.toggle()
                    cellViewModel.performUpdateCell()
                }
                Button("Random") {
                    cellViewModel.random()
                }
                
            }
            HStack {
                Text("Speed: ")
                Slider(value: $cellViewModel.time, in: 0...0.1)
                Text("\(cellViewModel.time, specifier: "%.2f") second")
            }
            HStack {
                Button("Save") {
                    cellViewModel.start = false
                    let savePanel = NSSavePanel()
                    savePanel.allowedContentTypes = [.json]
                    if savePanel.runModal() == .OK {
                        guard let fileUrl = savePanel.url else {
                            return
                        }
                        cellViewModel.save(path: fileUrl)
                    }
                }
                Button("Load") {
                    cellViewModel.start = false
                    let loadPanel = NSOpenPanel()
                    loadPanel.canChooseDirectories = false
                    loadPanel.allowsMultipleSelection = false
                    loadPanel.allowedContentTypes = [.json]
                    if loadPanel.runModal() == .OK {
                        guard let fileUrl = loadPanel.url else {
                            return
                        }
                        cellViewModel.load(path: fileUrl)
                    }
                }
            }
        }
        .frame(width: 200)
    }
}

struct BasicControlView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var cell: Cell = CellSetViewModel(time: 0.1, rowSize: 50, colSize: 50)
        ControlerView()
            .environmentObject(cell)
    }
}
