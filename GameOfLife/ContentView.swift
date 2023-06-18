//
//  ContentView.swift
//  GameOfLife
//
//  Created by Elvis on 15/06/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var cell = Cell2(rowSize: 50, colSize: 50)
    @State private var start = false
    
    var body: some View {
        VStack {
            GridView(start: $start)
                .environmentObject(cell)
            HStack {
                Button("Reset") {
                    start = false
                    cell.reset()
                }
                Button("Start / Stop") {
                    start.toggle()
                    DispatchQueue.global(qos: .userInitiated).async {
                        while (start) {
                            cell.updateCell()
                        }
                    }
                }
                Button("Random") {
                    cell.random()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
