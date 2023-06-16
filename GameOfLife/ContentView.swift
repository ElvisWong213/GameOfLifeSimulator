//
//  ContentView.swift
//  GameOfLife
//
//  Created by Elvis on 15/06/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var cell = Cell(rowSize: 80, colSize: 80)
    @State private var start = false
    
    var body: some View {
        VStack {
            GridView(start: $start)
                .environmentObject(cell)
            HStack {
                Button("Reset") {
                    cell.reset()
                }
                Button("Start / Stop") {
                    start.toggle()
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
