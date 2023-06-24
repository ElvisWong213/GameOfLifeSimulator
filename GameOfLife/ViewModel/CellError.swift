//
//  CellError.swift
//  GameOfLife
//
//  Created by Elvis on 22/06/2023.
//

import Foundation

public enum CellError: Error {
    case rowIndexOutOfRange(message: String = "Row is out of range")
    case colIndexOutOfRange(message: String = "Column is out of range")
    case indexOutOfRange(message: String = "index is out of range")
}
