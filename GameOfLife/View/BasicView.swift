//
//  BasicView.swift
//  GameOfLife
//
//  Created by Elvis on 19/06/2023.
//

import SwiftUI

struct BasicView: View {
    @StateObject var cellViewModel: Cell = CellDictionaryViewModel(time: 0.1, rowSize: 50, colSize: 50)
    @State private var size: CGFloat = 10.0
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                GridView(cellSize: .constant(size))
                    .padding()
                    .environmentObject(cellViewModel)
                Library()
                    .padding()
                Spacer()
            }
            ControlerView()
                .environmentObject(cellViewModel)
                .padding()
        }
        .onDisappear() {
            cellViewModel.start = false
        }
    }
}

struct BasicView_Previews: PreviewProvider {
    static var previews: some View {
        BasicView()
    }
}
