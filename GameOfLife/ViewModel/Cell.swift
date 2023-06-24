//
//  Cell.swift
//  GameOfLife
//
//  Created by Elvis on 22/06/2023.
//

import Foundation
import SwiftUI

class Cell: ObservableObject {
    @Published var start: Bool
    @Published var time: Float
    let rowSize: Int
    let colSize: Int
    
    
    init(start: Bool, time: Float, rowSize: Int, colSize: Int) {
        if type(of: self) == Cell.self {
           fatalError("Cell is an abstract class and cannot be instantiated directly.")
       }
        self.start = start
        self.time = time
        self.rowSize = rowSize
        self.colSize = colSize
    }
    
    @discardableResult func addCell(row: Int, col: Int, team: Teams = .None) -> Bool {
        fatalError("Subclasses must override abstractMethod.")
    }
    
    func removeCell(row: Int, col: Int) {
        fatalError("Subclasses must override abstractMethod.")
    }
    
    func isCoordinateValid(row: Int, col: Int) -> Bool {
        if (row < 0 || row > rowSize - 1) {
            return false
        }
        if (col < 0 || col > colSize - 1) {
            return false
        }
        return true
    }
    
    func isCellAlive(row: Int, col: Int, team: Teams = .None) -> Bool {
        fatalError("Subclasses must override abstractMethod.")
    }
    
    func countNeighbours(row: Int, col: Int, team: Teams = .None) -> Int {
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
    
    func checkCellNextGeneration(row: Int, col: Int, team: Teams = Teams.None) throws -> Bool {
        if !(isCoordinateValid(row: row, col: col)) {
            throw CellError.indexOutOfRange()
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
    
    func performUpdateCell() {
        DispatchQueue.global(qos: .userInitiated).async {
            while (self.start) {
                self.updateCell()
            }
        }
    }
    
    func updateCell() {
        fatalError("Subclasses must override abstractMethod.")
    }
    
    func reset() {
        fatalError("Subclasses must override abstractMethod.")
    }
    
    func showColor(row: Int, col: Int) -> Color {
        if isCellAlive(row: row, col: col) {
            return .black
        }
        return .gray
    }
    
    func randomGenerateCell() {
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
    
    func random() {
        reset()
        randomGenerateCell()
    }
}
