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
