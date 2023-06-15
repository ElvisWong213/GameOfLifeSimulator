//
//  GridView.swift
//  GameOfLife
//
//  Created by Elvis on 18/04/2023.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject var cell: Cell
    @Binding var start: Bool
    
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            ForEach(cell.cellList.indices, id: \.self) { row in
                GridRow() {
                    ForEach(cell.cellList[row].indices, id: \.self) { col in
                        Rectangle()
                            .foregroundColor(cell.cellList[row][col] ? .black : .gray)
                            .frame(width: 8, height: 8)
                            .fixedSize()
                            .onTapGesture {
                                cell.cellList[row][col].toggle()
                            }
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            if start {
                cell.perform()
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(start: .constant(false))
    }
}
