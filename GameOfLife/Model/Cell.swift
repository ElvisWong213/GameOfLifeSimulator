//
//  Cell.swift
//  GameOfLife
//
//  Created by Elvis on 22/06/2023.
//

import Foundation
import SwiftUI

class Cell: ObservableObject, Codable, SaveLoadFile {
    @Published var start: Bool
    @Published var time: Float
    var rowSize: Int
    var colSize: Int
    
    
    init(start: Bool, time: Float, rowSize: Int, colSize: Int) {
        if type(of: self) == Cell.self {
           fatalError("Cell is an abstract class and cannot be instantiated directly.")
       }
        self.start = start
        self.time = time
        self.rowSize = rowSize
        self.colSize = colSize
    }
    
    required init(from decoder: Decoder) throws {
        let continer = try decoder.container(keyedBy: CodingKeys.self)
        
        start = try continer.decode(Bool.self, forKey: .start)
        time = try continer.decode(Float.self, forKey: .time)
        rowSize = try continer.decode(Int.self, forKey: .rowSize)
        colSize = try continer.decode(Int.self, forKey: .colSize)
    }
    
    private enum CodingKeys: CodingKey {
        case start, time, rowSize, colSize
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(start, forKey: .start)
        try container.encode(time, forKey: .time)
        try container.encode(rowSize, forKey: .rowSize)
        try container.encode(colSize, forKey: .colSize)
    }
    
    @discardableResult func addCell(row: Int, col: Int, team: Teams = .None) -> Bool {
        fatalError("Subclasses must override abstractMethod.")
    }
    
    func removeCell(row: Int, col: Int) {
        fatalError("Subclasses must override abstractMethod.")
    }
    
    func viewTapCell(row: Int, col: Int) {
        if isCellAlive(row: row, col: col) {
            removeCell(row: row, col: col)
        } else {
            addCell(row: row, col: col)
        }
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
    
    func clear() {
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
        clear()
        randomGenerateCell()
    }
    
    func save(path: String) -> Bool {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let url = URL(string: path) else {
            return false
        }
        do {
            let data = try encoder.encode(self)
            try data.write(to: url)
        } catch {
            print("Unable to encode")
            return false
        }
        return true
    }
    
    func load(path: String) {
        guard let url = URL(string: path) else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let continer = try decoder.decode(Cell.self, from: data)
            
            start = continer.start
            time = continer.time
            rowSize = continer.rowSize
            colSize = continer.colSize
        } catch {
            print("Can't load file")
        }
    }
    
}
