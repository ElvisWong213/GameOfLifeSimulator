//
//  BasicGridView.swift
//  GameOfLife
//
//  Created by Elvis on 18/04/2023.
//

import SwiftUI

struct BasicGridView: View {
    @EnvironmentObject var cellSetViewModel: CellSetViewModel
    @Binding var cellSize: CGFloat
            
    var body: some View {
        LazyVStack(spacing: 1) {
            ForEach(0..<cellSetViewModel.getRowSize(), id: \.self) { row in
                LazyHStack(spacing: 1) {
                    ForEach(0..<cellSetViewModel.getColSize(), id: \.self) { col in
                        Rectangle()
                            .foregroundColor(cellSetViewModel.isCellExist(row: row, col: col) ? .black : .gray)
                            .frame(width: cellSize, height: cellSize)
                            .fixedSize()
                            .onTapGesture {
                                if cellSetViewModel.isCellExist(row: row, col: col) {
                                    try! cellSetViewModel.removeCell(row: row, col: col)
                                } else {
                                    try! cellSetViewModel.addCell(row: row, col: col)
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
