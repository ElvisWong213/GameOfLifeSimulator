//
//  CellTests.swift
//  CellTests
//
//  Created by Elvis on 15/06/2023.
//

import XCTest

final class CellTests: XCTestCase {
    private var cell: Cell!

    override func setUpWithError() throws {
        cell = Cell(rowSize: 500, colSize: 500)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testCellPerformPerformance() throws {
        // This is an example of a performance test case.
        measure {
            cell.perform()
        }
    }
    
    func testCellRandomPerformance() throws {
        measure {
            cell.random()
        }
    }

}
