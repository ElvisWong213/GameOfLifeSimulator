//
//  Cell2.swift
//  GameOfLife
//
//  Created by Elvis on 16/06/2023.
//

import Foundation

class CellSetViewModel: Cell {
    @Published var cellSet: Set<CellCoordinate>
    @Published var checkCellSet: Set<CellCoordinate>
    
    init(cellSet: Set<CellCoordinate> = Set<CellCoordinate>(), checkCellSet: Set<CellCoordinate> = Set<CellCoordinate>(), start: Bool = false, time: Float, rowSize: Int, colSize: Int) {
        self.cellSet = cellSet
        self.checkCellSet = checkCellSet
        super.init(start: start, time: time, rowSize: rowSize, colSize: colSize)
    }
    
    @discardableResult public override func addCell(row: Int, col: Int) -> Bool {
        for r in row - 1 ... row + 1 {
            for c in col - 1 ... col + 1 {
                if isCoordinateValid(row: r, col: c) {
                    checkCellSet.insert(CellCoordinate(row: r, col: c))
                }
            }
        }
        return cellSet.insert(CellCoordinate(row: row, col: col)).inserted
    }
    
    public override func removeCell(row: Int, col: Int) {
        cellSet.remove(CellCoordinate(row: row, col: col))
    }
    
    public override func isCellAlive(row: Int, col: Int) -> Bool {
        return cellSet.contains(CellCoordinate(row: row, col: col))
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
        var newSet = Set<CellCoordinate>()
        var newCheckSet = Set<CellCoordinate>()
        for coordinate in checkCellSet {
            if try! checkCellNextGeneration(row: coordinate.row, col: coordinate.col) {
                for r in coordinate.row - 1 ... coordinate.row + 1 {
                    for c in coordinate.col - 1 ... coordinate.col + 1 {
                        if isCoordinateValid(row: r, col: c) {
                            newCheckSet.insert(CellCoordinate(row: r, col: c))
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
    
    public override func reset() {
        cellSet = Set<CellCoordinate>()
        checkCellSet = Set<CellCoordinate>()
    }
}
