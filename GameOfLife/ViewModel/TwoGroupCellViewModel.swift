//
//  CellSetViewModelForTwoGroupMode.swift
//  GameOfLife
//
//  Created by Elvis on 20/06/2023.
//

import Foundation
import SwiftUI

class TwoGroupCellViewModel: Cell {
    @Published var cells: Dictionary<CellCoordinate, Teams>
    @Published var team: Teams
    
    override init(start: Bool = false, time: Float, rowSize: Int, colSize: Int) {
        self.cells = Dictionary<CellCoordinate, Teams>()
        self.team = .Host
        super.init(start: start, time: time, rowSize: rowSize, colSize: colSize)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cells = try container.decode(Dictionary<CellCoordinate, Teams>.self, forKey: .cells)
        team = try container.decode(Teams.self, forKey: .team)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: CodingKey {
        case cells, team
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try super.encode(to: encoder)
        try container.encode(cells, forKey: .cells)
        try container.encode(team, forKey: .team)
    }
    
    @discardableResult override func addCell(row: Int, col: Int, team: Teams) -> Bool {
        if isCellAlive(row: row, col: col, team: team) {
            return false
        }
        var isAdd = false
        for r in row - 1 ... row + 1 {
            for c in col - 1 ... col + 1 {
                if isCoordinateValid(row: r, col: c) {
                    if (r == row && c == col) || isCellAlive(row: r, col: c, team: team) {
                        isAdd = true
                        cells[CellCoordinate(row: r, col: c)] = team
                    } else if !isCellAlive(row: r, col: c, team: .Host) && !isCellAlive(row: r, col: c, team: .Guest) {
                        cells[CellCoordinate(row: r, col: c)] = Teams.None
                    }
                }
            }
        }
        return isAdd
    }
    
    override func removeCell(row: Int, col: Int) {
        cells.removeValue(forKey: CellCoordinate(row: row, col: col))
    }
    
    override func viewTapCell(row: Int, col: Int) {
        if isCellAlive(row: row, col: col, team: .Host) || isCellAlive(row: row, col: col, team: .Guest) {
            removeCell(row: row, col: col)
        } else {
            addCell(row: row, col: col, team: self.team)
        }
    }
    
    override func isCellAlive(row: Int, col: Int, team: Teams) -> Bool {
        if cells[CellCoordinate(row: row, col: col)] == .None{
            return false
        }
        if cells[CellCoordinate(row: row, col: col)] == team{
            return true
        }
        return false
    }
    
    override func countNeighbours(row: Int, col: Int, team: Teams) -> Int {
        if team == .None {
            return 0
        }
        var counter = 0
        
        for r in row - 1 ... row + 1 {
            for c in col - 1 ... col + 1 {
                if (r, c) == (row, col) {
                    continue
                }
                if isCellAlive(row: r, col: c, team: team) {
                    counter += 1
                }
            }
        }
        return counter
    }
    
    override func checkCellNextGeneration(row: Int, col: Int, team: Teams) throws -> Bool {
        if !(isCoordinateValid(row: row, col: col)) {
            throw CellError.indexOutOfRange()
        }
        let newTeam = newTeam(row: row, col: col, team: team)
        let numberOfNeighbours = countNeighbours(row: row, col: col, team: newTeam)
        if isCellAlive(row: row, col: col, team: team) {
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
    
    func newTeam(row: Int, col: Int, team: Teams) -> Teams {
        let hostNumberOfNeighbours = countNeighbours(row: row, col: col, team: .Host)
        let guestNumberOfNeighbours = countNeighbours(row: row, col: col, team: .Guest)
        var newTeam = team
        if hostNumberOfNeighbours > guestNumberOfNeighbours {
            newTeam = .Host
        } else if hostNumberOfNeighbours < guestNumberOfNeighbours {
            newTeam = .Guest
        }
        return newTeam
        
    }
    
    override func updateCell() {
        if !start {
            return
        }
        var newCells = Dictionary<CellCoordinate, Teams>()
        cells.forEach({(key, value) in
            let row = key.row
            let col = key.col
            if try! checkCellNextGeneration(row: row, col: col, team: value) {
                for r in row - 1 ... row + 1 {
                    for c in col - 1 ... col + 1 {
                        if isCoordinateValid(row: r, col: c) {
                            if (r == row && c == col) {
                                let newTeam = newTeam(row: r, col: c, team: value)
                                newCells[CellCoordinate(row: r, col: c)] = newTeam
                            } else if newCells[CellCoordinate(row: r, col: c)] == nil {
                                newCells[CellCoordinate(row: r, col: c)] = .None
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
    
    override func randomGenerateCell() {
        let teams: [Teams] = [.Host, .Guest]
        for team in teams {
            let total = rowSize * colSize / 8
            var count = 0
            while (count < total) {
                if team == .Host {
                    let row = Int.random(in: 0..<rowSize)
                    let col = Int.random(in: 0..<colSize/2)
                    if addCell(row: row, col: col, team: team) {
                        count += 1
                    }
                } else {
                    let row = Int.random(in: 0..<rowSize)
                    let col = Int.random(in: colSize/2..<colSize)
                    if addCell(row: row, col: col, team: team) {
                        count += 1
                    }
                    
                }
            }
        }
    }
    
    override func showColor(row: Int, col: Int) -> Color {
        switch cells[CellCoordinate(row: row, col: col)] {
        case .None:
            return .gray
        case .Guest:
            return .red
        case .Host:
            return .blue
        default:
            return .gray
        }
    }
    
    override func clear() {
        cells = Dictionary<CellCoordinate, Teams>()
    }
    
    func changeTeam(team: Teams) {
        self.team = team
    }
    
    override func load(path: URL) {
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            let continer = try decoder.decode(TwoGroupCellViewModel.self, from: data)
            
            super.load(path: path)
            cells = continer.cells
            team = continer.team
        } catch {
            print("Can't load file")
        }
    }
    
}
