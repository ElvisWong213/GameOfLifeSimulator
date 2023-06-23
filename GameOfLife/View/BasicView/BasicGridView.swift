//
//  BasicGridView.swift
//  GameOfLife
//
//  Created by Elvis on 18/04/2023.
//

import SwiftUI

struct BasicGridView: View {
    @EnvironmentObject var cellViewModel: Cell
    @Binding var cellSize: CGFloat
            
    var body: some View {
        LazyVStack(spacing: 1) {
            ForEach(0..<cellViewModel.rowSize, id: \.self) { row in
                LazyHStack(spacing: 1) {
                    ForEach(0..<cellViewModel.colSize, id: \.self) { col in
                        Rectangle()
                            .foregroundColor(cellViewModel.showColor(row: row, col: col))
                            .frame(width: cellSize, height: cellSize)
                            .fixedSize()
                            .onTapGesture {
                                if cellViewModel.isCellAlive(row: row, col: col) {
                                    cellViewModel.removeCell(row: row, col: col)
                                } else {
                                    cellViewModel.addCell(row: row, col: col)
                                }
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
        BasicGridView(cellSize: .constant(10.0))
    }
}
