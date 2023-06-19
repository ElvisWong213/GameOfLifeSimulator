//
//  Cell.swift
//  GameOfLife
//
//  Created by Elvis on 18/04/2023.
//

import Foundation

/// Control the all the action of the cell
class Cell: ObservableObject {
    /// Store all the state (True = alive, False = dead)
    @Published var cellList: [[Bool]]
    /// The number of row
    private var rowSize: Int
    /// The number of column
    private var colSize: Int
        
    /// Constructor of the Cell class
    /// - Parameters:
    ///   - rowSize: Number of row
    ///   - colSize: Number of column
    init(rowSize: Int, colSize: Int) {
        self.rowSize = rowSize
        self.colSize = colSize
        self.cellList = Array(repeating: Array(repeating: false, count: colSize), count: rowSize)
    }
    
    /// Set cell to alive
    /// - Parameters:
    ///   - row: Index of row
    ///   - col: Index of column
    public func setCellAlive(row: Int, col: Int) {
        if (row < 0 || col < 0 || row >= rowSize || col >= colSize) {
            print("index out of range")
            return
        }
        
        cellList[row][col] = true
    }
    
    
    /// Set cell to dead
    /// - Parameters:
    ///   - row: Index of row
    ///   - col: Index of column
    public func setCellDead(row: Int, col: Int) {
        if (row < 0 || col < 0 || row >= rowSize || col >= colSize) {
            print("index out of range")
            return
        }
        
        cellList[row][col] = false
        
    }
    
    
    /// Count alive neighbours of the cell
    /// - Parameters:
    ///   - row: Index of row
    ///   - col: Index of column
    /// - Returns: The number of neighbours
    public func countNeighbours(row: Int, col: Int) -> Int {
        var counter = 0
        
        for r in (row - 1) ... (row + 1) {
            for c in (col - 1) ... (col + 1) {
                if (r < 0 || r >= rowSize || c < 0 || c >= colSize) {
                    continue
                }
                if r == row && c == col {
                    continue
                }
                if cellList[r][c] {
                    counter += 1
                }
            }
        }
        return counter
    }
    
    /// Check next generation of the cell
    /// - Parameters:
    ///   - row: Index of row
    ///   - col: Index of column
    /// - Returns: The state of the cell in next generatiob
    public func checkCellNextGeneration(row: Int, col: Int) -> Bool {
        let numberOfNeighbours = countNeighbours(row: row, col: col)
        if cellList[row][col] == false {
            if numberOfNeighbours == 3 {
                return true
            } else {
                return false
            }
        } else {
            if numberOfNeighbours >= 2 && numberOfNeighbours <= 3 {
                return true
            } else {
                return false
            }
        }
    }
    
    /// Get rowSize
    /// - Returns: The size of row
    public func getRowSize() -> Int {
        return rowSize
    }
    
    /// Get colSize
    /// - Returns: The size of column
    public func getColSize() -> Int {
        return colSize
    }
    
    /// Get cell state
    /// - Parameters:
    ///   - row: Index of row
    ///   - col: Index of column
    /// - Returns: The state of the cell (True = alive, False = dead)
    public func cellIsAlive(row: Int, col: Int) -> Bool {
        return cellList[row][col]
    }
    
    /// Toggle the cell in cell list
    /// - Parameters:
    ///   - row: Index of row
    ///   - col: Index of column
    public func toggleCellInCellList(row: Int, col: Int) {
        cellList[row][col].toggle()
    }
    
    /// Perform the action, update all cell
    public func updateCell() {
        var dummyList: [[Bool]] = Array(repeating: Array(repeating: false, count: colSize), count: rowSize)
        for row in 0..<rowSize {
            for col in 0..<colSize {
                let result = checkCellNextGeneration(row: row, col: col)
                dummyList[row][col] = result
            }
        }
        cellList = dummyList
    }
    
    /// Generate random cell to the cell list
    public func randomGenerateCell() {
        for _ in 0 ..< rowSize * colSize / 8 {
            let x = Int.random(in: 0..<rowSize)
            let y = Int.random(in: 0..<colSize)
            setCellAlive(row: y, col: x)
        }
    }
    
    /// Reset the cell list
    public func reset() {
        cellList = Array(repeating: Array(repeating: false, count: colSize), count: rowSize)
    }
    
    /// Perform random action
    public func random() {
        reset()
        randomGenerateCell()
    }
}
