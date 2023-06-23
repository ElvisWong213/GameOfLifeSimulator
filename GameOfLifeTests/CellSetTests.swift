//
//  Cell2Tests.swift
//  GameOfLifeTests
//
//  Created by Elvis on 16/06/2023.
//

import XCTest

final class CellSetViewModelTests: XCTestCase {
    private var cell: CellSetViewModel!

    override func setUpWithError() throws {
        cell = CellSetViewModel(time: 0, rowSize: 100, colSize: 100)
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
