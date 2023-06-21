//
//  Cell2.swift
//  GameOfLife
//
//  Created by Elvis on 16/06/2023.
//

import Foundation

enum CellError: Error {
    case rowIndexOutOfRange(message: String = "Row is out of range")
    case colIndexOutOfRange(message: String = "Column is out of range")
}

class CellSetViewModel: ObservableObject {
    @Published var cellSet: Set<MyCell>
    @Published var checkCellSet: Set<MyCell>
    @Published var start: Bool
    @Published var time: Float
    @Published private(set) var rowSize: Int
    @Published private(set) var colSize: Int
    
    init(cellSet: Set<MyCell> = Set<MyCell>(), checkCellSet: Set<MyCell> = Set<MyCell>(), start: Bool = false, time: Float, rowSize: Int, colSize: Int) {
        self.cellSet = cellSet
        self.checkCellSet = checkCellSet
        self.start = start
        self.time = time
        self.rowSize = rowSize
        self.colSize = colSize
    }
    
    public func getRowSize() -> Int {
        return rowSize
    }
    
    public func getColSize() -> Int {
        return colSize
    }
    
    public func toggleStart() {
        start.toggle()
    }
    
    public func getStart() -> Bool {
        return start
    }
    
    public func setTime(time: Float) {
        self.time = time
    }
    
    public func getTime() -> Float {
        return time
    }
    
    @discardableResult public func addCell(row: Int, col: Int) throws -> Bool {
        for r in row - 1 ... row + 1 {
            for c in col - 1 ... col + 1 {
                if isCoordinateValid(row: r, col: c) {
                    checkCellSet.insert(MyCell(row: r, col: c))
                }
            }
        }
        return cellSet.insert(MyCell(row: row, col: col)).inserted
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
    
    public func removeCell(row: Int, col: Int) throws {
        cellSet.remove(MyCell(row: row, col: col))
    }
    
    public func isCellExist(row: Int, col: Int) -> Bool {
        return cellSet.contains(MyCell(row: row, col: col))
    }
    
    public func countNeighbours(row: Int, col: Int) -> Int {
        var counter = 0
        
        for r in row - 1 ... row + 1 {
            for c in col - 1 ... col + 1 {
                if (r, c) == (row, col) {
                    continue
                }
                if isCellExist(row: r, col: c) {
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
        if isCellExist(row: row, col: col) {
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
        var newSet = Set<MyCell>()
        var newCheckSet = Set<MyCell>()
        for coordinate in checkCellSet {
            if try! checkCellNextGeneration(row: coordinate.row, col: coordinate.col) {
                for r in coordinate.row - 1 ... coordinate.row + 1 {
                    for c in coordinate.col - 1 ... coordinate.col + 1 {
                        if isCoordinateValid(row: r, col: c) {
                            newCheckSet.insert(MyCell(row: r, col: c))
                        }
                    }
                }
                newSet.insert(coordinate)
            }
        }
        DispatchQueue.main.async {
            self.cellSet = newSet
            self.checkCellSet = newCheckSet
        }
        usleep(useconds_t(self.time * 1000000))
    }
    
    public func randomGenerateCell() {
        let total = rowSize * colSize / 8
        var count = 0
        while (count < total) {
            let row = Int.random(in: 0..<rowSize)
            let col = Int.random(in: 0..<colSize)
            if try! addCell(row: row, col: col) {
                count += 1
            }
        }
    }
    
    public func reset() {
        cellSet = Set<MyCell>()
        checkCellSet = Set<MyCell>()
    }
    
    public func random() {
        reset()
        randomGenerateCell()
    }
}
