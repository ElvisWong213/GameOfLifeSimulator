//
//  BasicView.swift
//  GameOfLife
//
//  Created by Elvis on 19/06/2023.
//

import SwiftUI

struct BasicView: View {
    @StateObject private var cell = Cell2(rowSize: 50, colSize: 50)
    @State private var size: CGFloat = 10.0
    @State private var start = false
    @State var time: Float = 0.1
    
    var body: some View {
        VStack {
            GridView(start: $start, cellSize: $size)
                .environmentObject(cell)
            HStack {
                Button("Reset") {
                    start = false
                    cell.reset()
                }
                Button(start ? "Stop" : "Start") {
                    start.toggle()
                    DispatchQueue.global(qos: .userInitiated).async {
                        while (start) {
                            cell.updateCell()
                            usleep(useconds_t(time * 1000000))
                        }
                    }
                }
                Button("Random") {
                    cell.random()
                }
                
            }
            HStack {
                Text("Speed: ")
                Slider(value: $time, in: 0.001...0.1)
                Text("\(time) second")
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
