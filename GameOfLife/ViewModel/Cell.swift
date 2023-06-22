//
//  Cell.swift
//  GameOfLife
//
//  Created by Elvis on 22/06/2023.
//

import Foundation

class Cell {
    @Published var start: Bool
    @Published var time: Float
    @Published private(set) var rowSize: Int
    @Published private(set) var colSize: Int
    
    init(start: Bool, time: Float, rowSize: Int, colSize: Int) {
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
    
    @discardableResult public func addCell(row: Int, col: Int) -> Bool {
        fatalError("addCell(row:, col:) has not been implemented")
    }
    
    public func isCoordinateValid(row: Int, col: Int) -> Bool {
        fatalError("isCoordinateValid(row:, col:) has not been implemented")
    }
    
    public func isCellExist(row: Int, col: Int) -> Bool {
        fatalError("isCellExist(row:, col:) has not been implemented")
    }
    
    public func countNeighbours(row: Int, col: Int) -> Int {
        fatalError("countNeighbours(row:, col:) has not been implemented")
    }
    
    public func checkCellNextGeneration(row: Int, col: Int) throws -> Bool {
        fatalError("checkCellNextGeneration(row:, col:) has not been implemented")
    }
    
    public func updateCell() {
        fatalError("updateCell() has not been implemented")
    }
    
    public func reset() {
        fatalError("reset() has not been implemented")
    }
}
