//
//  Cell.swift
//  GameOfLife
//
//  Created by Elvis on 22/06/2023.
//

import Foundation

protocol Cell {
    var start: Bool { get set }
    var time: Float { get set }
    var rowSize: Int { get }
    var colSize: Int { get } 
    
    @discardableResult func addCell(row: Int, col: Int) -> Bool
    
    func isCoordinateValid(row: Int, col: Int) -> Bool
    
    func isCellAlive(row: Int, col: Int) -> Bool
    
    func countNeighbours(row: Int, col: Int) -> Int 
    
    func checkCellNextGeneration(row: Int, col: Int) throws -> Bool
    
    func performUpdateCell()
    
    func updateCell()
    
    func reset()
    
    func randomGenerateCell()
    
    func random()
}
