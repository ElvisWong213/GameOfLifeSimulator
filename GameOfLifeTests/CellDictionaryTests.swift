//
//  CellDictionaryViewModelTests.swift
//  GameOfLifeTests
//
//  Created by Elvis on 22/06/2023.
//

import XCTest

final class CellDictionaryTests: XCTestCase {
    var cell: CellDictionaryViewModel!

    override func setUpWithError() throws {
        cell = CellDictionaryViewModel(time: 0, rowSize: 100, colSize: 100)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAdd() throws {
        cell.addCell(row: 0, col: 0)
        XCTAssertTrue(cell.isCellAlive(row: 0, col: 0))
    }
    
    func testUpdateCellPerformance() throws {
        cell.random()
        measure {
            cell.updateCell()
        }
    }
    
    func testUpdateCellPerformanceFillAllCell() throws {
        for r in 0..<cell.rowSize {
            for c in 0..<cell.colSize {
                cell.addCell(row: r, col: c)
            }
        }
        measure {
            cell.updateCell()
        }
    }
    

}
