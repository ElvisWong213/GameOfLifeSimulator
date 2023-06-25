//
//  BasicGridView.swift
//  GameOfLife
//
//  Created by Elvis on 18/04/2023.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject var cellViewModel: Cell
    @Binding var cellSize: CGFloat
            
    var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<cellViewModel.rowSize, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(0..<cellViewModel.colSize, id: \.self) { col in
                        Rectangle()
                            .foregroundColor(cellViewModel.showColor(row: row, col: col))
                            .frame(width: cellSize, height: cellSize)
                            .onTapGesture {
                                cellViewModel.viewTapCell(row: row, col: col)
                            }
                    }
                }
            }
        }
        .drawingGroup()
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var cell: Cell = CellSetViewModel(time: 0.1, rowSize: 10, colSize: 10)
        GridView(cellSize: .constant(10.0))
            .environmentObject(cell)
    }
}
