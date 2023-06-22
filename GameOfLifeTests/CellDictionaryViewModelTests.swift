//
//  CellDictionaryViewModelTests.swift
//  GameOfLifeTests
//
//  Created by Elvis on 22/06/2023.
//

import XCTest

final class CellDictionaryViewModelTests: XCTestCase {
    var cell: CellDictionaryViewModel!

    override func setUpWithError() throws {
        cell = CellDictionaryViewModel(start: true, time: 0, rowSize: 500, colSize: 500)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
