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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cells = try container.decode(Dictionary<CellCoordinate, Bool>.self, forKey: .cells)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: CodingKey {
        case cells
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try super.encode(to: encoder)
        try container.encode(cells, forKey: .cells)
    }
    
    @discardableResult public override func addCell(row: Int, col: Int, team: Teams = Teams.None) -> Bool {
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
    
    public override func isCellAlive(row: Int, col: Int, team: Teams = .None) -> Bool {
        return cells[CellCoordinate(row: row, col: col)] ?? false
    }
    
    
    public override func updateCell() {
        if !start {
            return
        }
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
    
    override func load(path: URL) {
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            let continer = try decoder.decode(CellDictionaryViewModel.self, from: data)
            
            super.load(path: path)
            cells = continer.cells
        } catch {
            print("Can't load file")
        }
    }
}
