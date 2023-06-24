//
//  ContentView.swift
//  GameOfLife
//
//  Created by Elvis on 15/06/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var set: Cell = CellSetViewModel(time: 0.1, rowSize: 50, colSize: 50)
    @StateObject var twoSet: Cell = TwoGroupCellViewModel(time: 0.1, rowSize: 50, colSize: 50)
    
    var body: some View {
        NavigationSplitView(
            sidebar: {
                List() {
                    NavigationLink {
                        BasicView()
                            .environmentObject(set)
                    } label: {
                        Label("Basic", systemImage: "app.fill")
                            .font(.title3)
                    }
                    NavigationLink {
                        BasicView()
                            .environmentObject(twoSet)
                    } label: {
                        Label("Two Group", systemImage: "app.fill")
                            .font(.title3)
                    }
                }
            }, detail: {
                Text("Please select mode")
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
