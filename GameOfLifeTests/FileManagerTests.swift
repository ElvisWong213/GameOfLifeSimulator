//
//  FileManagerTests.swift
//  GameOfLifeTests
//
//  Created by Elvis on 27/06/2023.
//

import XCTest

final class FileManagerTests: XCTestCase {
    var file: FileManager?

    override func setUpWithError() throws {
        file = FileManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let cells = CellSetViewModel(start: false, time: 0.1, rowSize: 10, colSize: 10)
        cells.addCell(row: 1, col: 1)
        let url = URL(filePath: "/Users/steve/Downloads/GameOfLifeData.json")
        cells.save(path: url)
    }

}
