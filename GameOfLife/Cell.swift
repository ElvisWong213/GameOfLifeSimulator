//
//  Cell.swift
//  GameOfLife
//
//  Created by Elvis on 18/04/2023.
//

import Foundation

class Cell: ObservableObject {
    @Published var cellList: [[Bool]]
    private final var size = 60
    
    init() {
        self.cellList = Array(repeating: Array(repeating: false, count: size), count: size)
    }
    
    public func CellLives(row: Int, col: Int) {
        if (row < 0 || col < 0 || row >= size || col >= size) {
            print("index out of range")
            return
        }
        
        cellList[row][col] = true
    }
    
    public func CellDead(row: Int, col: Int) {
        if (row < 0 || col < 0 || row >= size || col >= size) {
            print("index out of range")
            return
        }
        
        cellList[row][col] = false
        
    }
    
    public func countNeighbours(row: Int, col: Int) -> Int {
        var counter = 0
        
        for r in (row - 1) ... (row + 1) {
            for c in (col - 1) ... (col + 1) {
                if (r >= 0 && r < size) && (c >= 0 && c < size) {
                    if r != row || c != col {
                        if cellList[r][c] {
                            counter += 1
                        }
                    }
                }
            }
        }
        return counter
    }
    
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
    
    public func getCellList() ->[[Bool]] {
        return cellList
    }
    
    public func perform() {
        var dummyList: [[Bool]] = Array(repeating: Array(repeating: false, count: size), count: size)
        for row in 0..<size {
            for col in 0..<size {
                let result = checkCellNextGeneration(row: row, col: col)
                dummyList[row][col] = result
            }
        }
        cellList = dummyList
    }
    
    public func randomGenerateCell() {
        for _ in 0 ..< size * size / 4 {
            let x = Int.random(in: 0..<size)
            let y = Int.random(in: 0..<size)
            CellLives(row: y, col: x)
        }
    }
    
    public func reset() {
        cellList = Array(repeating: Array(repeating: false, count: size), count: size)
    }
    
    public func random() {
        reset()
        randomGenerateCell()
    }
}
