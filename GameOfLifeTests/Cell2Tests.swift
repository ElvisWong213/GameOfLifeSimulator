//
//  Cell2Tests.swift
//  GameOfLifeTests
//
//  Created by Elvis on 16/06/2023.
//

import XCTest

final class Cell2Tests: XCTestCase {
    private var cell: Cell2!

    override func setUpWithError() throws {
        cell = Cell2(rowSize: 200, colSize: 200)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        cell.random()
    }

    func testUpdateCellPerformanceExample() throws {
        cell.random()
        measure {
            cell.updateCell()
        }
    }

}
