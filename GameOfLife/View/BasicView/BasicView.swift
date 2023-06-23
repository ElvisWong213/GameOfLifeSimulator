//
//  BasicView.swift
//  GameOfLife
//
//  Created by Elvis on 19/06/2023.
//

import SwiftUI

struct BasicView: View {
    @StateObject private var cellViewModel: Cell = CellSetViewModel(time: 0.1, rowSize: 50, colSize: 50)
    @State private var size: CGFloat = 10.0
    
    var body: some View {
        VStack {
            BasicGridView(cellSize: $size)
                .environmentObject(cellViewModel)
            HStack {
                Button("Reset") {
                    cellViewModel.start = false
                    cellViewModel.reset()
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
            .frame(width: 200)
        }
    }
}

struct BasicView_Previews: PreviewProvider {
    static var previews: some View {
        BasicView()
    }
}
