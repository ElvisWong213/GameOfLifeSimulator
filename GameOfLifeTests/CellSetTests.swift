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
        cell = CellSetViewModel(time: 0, rowSize: 500, colSize: 500)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUpdateCellPerformanceExample() throws {
        cell.random()
        measure {
            cell.updateCell()
        }
    }

}
