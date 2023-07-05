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
    
    required init(from decoder: Decoder) throws {
        let continer = try decoder.container(keyedBy: CodingKeys.self)

        cellSet = try continer.decode(Set<CellCoordinate>.self, forKey: .cellSet)
        checkCellSet = try continer.decode(Set<CellCoordinate>.self, forKey: .checkCellSet)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: CodingKey {
        case cellSet, checkCellSet
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try super.encode(to: encoder)
        try container.encode(cellSet, forKey: .cellSet)
        try container.encode(checkCellSet, forKey: .checkCellSet)
    }
    
    @discardableResult public override func addCell(row: Int, col: Int, team: Teams = .None) -> Bool {
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
    
    public override func isCellAlive(row: Int, col: Int, team: Teams = .None) -> Bool {
        return cellSet.contains(CellCoordinate(row: row, col: col))
    }
    
    public override func updateCell() {
        if !start {
            return
        }
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
    
    public override func clear() {
        cellSet = Set<CellCoordinate>()
        checkCellSet = Set<CellCoordinate>()
    }
    
    override func load(path: URL) {
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            let continer = try decoder.decode(CellSetViewModel.self, from: data)
            
            super.load(path: path)
            cellSet = continer.cellSet
            checkCellSet = continer.checkCellSet
        } catch {
            print("Can't load file")
        }
    }
}
