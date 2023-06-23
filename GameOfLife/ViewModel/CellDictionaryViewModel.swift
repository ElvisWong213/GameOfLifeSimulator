//
//  CellHashTableViewModel.swift
//  GameOfLife
//
//  Created by Elvis on 22/06/2023.
//

import Foundation

class CellDictionaryViewModel: Cell {
    @Published var cells: Dictionary<CellCoordinate, Bool>
    
    init(cells: Dictionary<CellCoordinate, Bool> = Dictionary<CellCoordinate, Bool>(), start: Bool = false, time: Float, rowSize: Int, colSize: Int) {
        self.cells = cells
        super.init(start: start, time: time, rowSize: rowSize, colSize: colSize)
    }
    
    @discardableResult public override func addCell(row: Int, col: Int) -> Bool {
        var isAdd = false
        for r in row - 1 ... row + 1 {
            for c in col - 1 ... col + 1 {
                if isCoordinateValid(row: r, col: c) {
                    if (r == row && c == col) || isCellAlive(row: r, col: c) {
                        isAdd = true
                        cells[CellCoordinate(row: r, col: c)] = true
                    } else {
                        cells[CellCoordinate(row: r, col: c)] = false
                    }
                }
            }
        }
        return isAdd
    }
    
    public override func removeCell(row: Int, col: Int) {
        cells.removeValue(forKey: CellCoordinate(row: row, col: col))
    }
    
    public override func isCellAlive(row: Int, col: Int) -> Bool {
        return cells[CellCoordinate(row: row, col: col)] ?? false
    }
    
    public override func checkCellNextGeneration(row: Int, col: Int) throws -> Bool {
        if (row > rowSize - 1 || row < 0) {
            throw CellError.rowIndexOutOfRange()
        }
        if (col > colSize - 1 || row < 0) {
            throw CellError.colIndexOutOfRange()
        }
        let numberOfNeighbours = countNeighbours(row: row, col: col)
        if isCellAlive(row: row, col: col) {
            if numberOfNeighbours >= 2 && numberOfNeighbours <= 3  {
                return true
            }
        } else {
            if numberOfNeighbours == 3 {
                return true
            }
        }
        return false
    }
    
    public override func performUpdateCell() {
        DispatchQueue.global(qos: .userInitiated).async {
            while (self.start) {
                self.updateCell()
            }
        }
    }
    
    public override func updateCell() {
        var newCells = Dictionary<CellCoordinate, Bool>()
        cells.forEach({(key, value) in
            let row = key.row
            let col = key.col
            if try! checkCellNextGeneration(row: row, col: col) {
                for r in row - 1 ... row + 1 {
                    for c in col - 1 ... col + 1 {
                        if isCoordinateValid(row: r, col: c) {
                            if (r == row && c == col) {
                                newCells[CellCoordinate(row: r, col: c)] = true
                            } else if newCells[CellCoordinate(row: r, col: c)] == nil {
                                newCells[CellCoordinate(row: r, col: c)] = false
                            }
                        }
                    }
                }
            }
        })
        DispatchQueue.main.async {
            self.cells = newCells
        }
        usleep(useconds_t(self.time * 1000000))
    }
    
    public override func reset() {
        cells = Dictionary<CellCoordinate, Bool>()
    }
}
