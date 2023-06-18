//
//  GridView.swift
//  GameOfLife
//
//  Created by Elvis on 18/04/2023.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject var cell: Cell2
    @Binding var start: Bool
    
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        
    var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            ForEach(0..<cell.getRowSize(), id: \.self) { row in
                GridRow() {
                    ForEach(0..<cell.getColSize(), id: \.self) { col in
                        Rectangle()
                            .foregroundColor(cell.isCellExist(row: row, col: col) ? .black : .gray)
                            .frame(width: 8, height: 8)
                            .fixedSize()
                            .onTapGesture {
                                if cell.isCellExist(row: row, col: col) {
                                    try! cell.removeCell(row: row, col: col)
                                } else {
                                    let _ = try! cell.addCell(row: row, col: col)
                                }
                            }
                    }
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(start: .constant(false))
    }
}
