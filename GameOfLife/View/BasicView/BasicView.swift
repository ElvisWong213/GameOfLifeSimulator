//
//  BasicView.swift
//  GameOfLife
//
//  Created by Elvis on 19/06/2023.
//

import SwiftUI

struct BasicView: View {
    @StateObject private var cellSetViewModel = CellSetViewModel(time: 0.1, rowSize: 50, colSize: 50)
    @State private var size: CGFloat = 10.0
    
    var body: some View {
        VStack {
            BasicGridView(cellSize: $size)
                .environmentObject(cellSetViewModel)
            HStack {
                Button("Reset") {
                    cellSetViewModel.start = false
                    cellSetViewModel.reset()
                }
                Button(cellSetViewModel.start ? "Stop" : "Start") {
                    cellSetViewModel.start.toggle()
                    cellSetViewModel.performUpdateCell()
                }
                Button("Random") {
                    cellSetViewModel.random()
                }
                
            }
            HStack {
                Text("Speed: ")
                Slider(value: $cellSetViewModel.time, in: 0.001...0.1)
                Text("\(cellSetViewModel.time, specifier: "%.2f") second")
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
