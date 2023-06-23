//
//  CellTests.swift
//  CellTests
//
//  Created by Elvis on 15/06/2023.
//

import XCTest

final class CellArrayTests: XCTestCase {
    private var cell: CellArrayViewModel!

    override func setUpWithError() throws {
        cell = CellArrayViewModel(rowSize: 100, colSize: 100)
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
        for r in 0..<cell.getRowSize() {
            for c in 0..<cell.getColSize() {
                cell.setCellAlive(row: r, col: c)
            }
        }
        measure {
            cell.updateCell()
        }
    }
}
