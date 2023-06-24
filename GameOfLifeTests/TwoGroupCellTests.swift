//
//  TwoGroupCellTests.swift
//  GameOfLifeTests
//
//  Created by Elvis on 23/06/2023.
//

import XCTest

final class TwoGroupCellTests: XCTestCase {
    var cell: TwoGroupCellViewModel!

    override func setUpWithError() throws {
        cell = TwoGroupCellViewModel(time: 0, rowSize: 100, colSize: 100)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddCell() throws {
        cell.addCell(row: 0, col: 0, team: .Host)
        XCTAssertEqual(.Host, cell.cells[CellCoordinate(row: 0, col: 0)])
        cell.addCell(row: 0, col: 0, team: .Guest)
        XCTAssertEqual(.Host, cell.cells[CellCoordinate(row: 0, col: 0)])
    }
    
    func testRandom() throws {
    }

}
