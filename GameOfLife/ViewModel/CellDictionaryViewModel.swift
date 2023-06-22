//
//  CellHashTableViewModel.swift
//  GameOfLife
//
//  Created by Elvis on 22/06/2023.
//

import Foundation

class CellDictionaryViewModel: Cell, ObservableObject {
    @Published var cells: Dictionary<MyCell, Bool>
    @Published var start: Bool
    @Published var time: Float
    let rowSize: Int
    let colSize: Int
    
    init(cells: Dictionary<MyCell, Bool> = Dictionary<MyCell, Bool>(), start: Bool = false, time: Float, rowSize: Int, colSize: Int) {
        self.cells = cells
        self.start = start
        self.time = time
        self.rowSize = rowSize
        self.colSize = colSize
    }
    
    @discardableResult public func addCell(row: Int, col: Int) -> Bool {
        var isAdd = false
        for r in row - 1 ... row + 1 {
            for c in col - 1 ... col + 1 {
                if isCoordinateValid(row: r, col: c) {
                    if (r == row && c == col) {
                        isAdd = true
                        cells[MyCell(row: row, col: col)] = true
                    } else {
                        cells[MyCell(row: row, col: col)] = false
                    }
                }
            }
        }
        return isAdd
    }
    
    public func isCoordinateValid(row: Int, col: Int) -> Bool {
        if (row < 0 || row > rowSize - 1) {
            return false
        }
        if (col < 0 || col > colSize - 1) {
            return false
        }
        return true
    }
    
    public func isCellAlive(row: Int, col: Int) -> Bool {
        return cells[MyCell(row: row, col: col)] ?? false
    }
    
    public func countNeighbours(row: Int, col: Int) -> Int {
        var counter = 0
        
        for r in row - 1 ... row + 1 {
            for c in col - 1 ... col + 1 {
                if (r, c) == (row, col) {
                    continue
                }
                if isCellAlive(row: r, col: c) {
                    counter += 1
                }
            }
        }
        return counter
    }
    
    public func checkCellNextGeneration(row: Int, col: Int) throws -> Bool {
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
    
    public func performUpdateCell() {
        DispatchQueue.global(qos: .userInitiated).async {
            while (self.start) {
                self.updateCell()
            }
        }
    }
    
    public func updateCell() {
        var newCells = Dictionary<MyCell, Bool>()
        cells.forEach({(key, value) in
            let row = key.row
            let col = key.col
            if try! checkCellNextGeneration(row: row, col: col) {
                for r in row - 1 ... row + 1 {
                    for c in col - 1 ... col + 1 {
                        if isCoordinateValid(row: r, col: c) {
                            if (r == row && c == col) {
                                newCells[MyCell(row: row, col: col)] = true
                            } else {
                                newCells[MyCell(row: row, col: col)] = false
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
    
    public func reset() {
        cells = Dictionary<MyCell, Bool>()
    }
    
    public func randomGenerateCell() {
        let total = rowSize * colSize / 8
        var count = 0
        while (count < total) {
            let row = Int.random(in: 0..<rowSize)
            let col = Int.random(in: 0..<colSize)
            if addCell(row: row, col: col) {
                count += 1
            }
        }
    }
    
    public func random() {
        reset()
        randomGenerateCell()
    }
}
