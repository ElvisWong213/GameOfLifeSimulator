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

class Cell2: ObservableObject {
    @Published var cellSet: Set<Int>
    private var checkCellSet: Set<Int>
    private var rowSize: Int
    private var colSize: Int
    
    init(rowSize: Int, colSize: Int) {
        self.cellSet = Set<Int>()
        self.checkCellSet = Set<Int>()
        self.rowSize = rowSize
        self.colSize = colSize
    }
    
    public func getRowSize() -> Int {
        return rowSize
    }
    
    public func setRowSize(size: Int) {
        rowSize = size
    }
    
    public func getColSize() -> Int {
        return colSize
    }
    
    public func setColSize(size: Int) {
        colSize = size
    }
    
    public func addCell(row: Int, col: Int) throws -> Bool {
        let index = try coordinateToIndex(row: row, col: col)
        for r in row - 1 ... row + 1 {
            for c in col - 1 ... col + 1 {
                do {
                    let otherIndex = try coordinateToIndex(row: r, col: c)
                    checkCellSet.insert(otherIndex)
                } catch {
                    continue
                }
            }
        }
        return cellSet.insert(index).inserted
    }
    
    public func removeCell(row: Int, col: Int) throws {
        let index = try coordinateToIndex(row: row, col: col)
        cellSet.remove(index)
    }
    
    public func isCellExist(row: Int, col: Int) -> Bool {
        var index: Int!
        do {
            index = try coordinateToIndex(row: row, col: col)
        } catch {
            return false
        }
        return cellSet.contains(index)
    }
    
    public func indexToCoordinate(index: Int) throws -> (row: Int, col: Int) {
        let row = index / colSize
        let col = index % colSize
        if (row > rowSize - 1 || row < 0) {
            throw CellError.rowIndexOutOfRange()
        }
        if (col > colSize - 1 || row < 0) {
            throw CellError.colIndexOutOfRange()
        }
        return (row, col)
    }
    
    public func coordinateToIndex(row: Int, col: Int) throws -> Int {
        if (row > rowSize - 1 || row < 0) {
            throw CellError.rowIndexOutOfRange()
        }
        if (col > colSize - 1 || row < 0) {
            throw CellError.colIndexOutOfRange()
        }
        return row * colSize + col
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
    
    public func updateCell() {
        var newSet = Set<Int>()
        var newCheckSet = Set<Int>()
        for index in checkCellSet {
            let coordinate: (row: Int, col: Int) = try! indexToCoordinate(index: index)
            if try! checkCellNextGeneration(row: coordinate.row, col: coordinate.col) {
                for r in coordinate.row - 1 ... coordinate.row + 1 {
                    for c in coordinate.col - 1 ... coordinate.col + 1 {
                        do {
                            let otherIndex = try coordinateToIndex(row: r, col: c)
                            newCheckSet.insert(otherIndex)
                        } catch {
                            continue
                        }
                    }
                }
                newSet.insert(index)
            }
        }
        DispatchQueue.main.async {
            self.cellSet = newSet
        }
        checkCellSet = newCheckSet
    }
    
    public func randomGenerateCell() {
        for _ in 0 ..< rowSize * colSize / 8 {
            let row = Int.random(in: 0..<rowSize)
            let col = Int.random(in: 0..<colSize)
            let _ = try! addCell(row: row, col: col)
        }
    }
    
    public func reset() {
        cellSet = Set<Int>()
        checkCellSet = Set<Int>()
    }
    
    public func random() {
        reset()
        randomGenerateCell()
    }
}
