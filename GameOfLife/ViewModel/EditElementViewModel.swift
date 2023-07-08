//
//  EditElementViewModel.swift
//  GameOfLife
//
//  Created by Elvis on 06/07/2023.
//

import Foundation

class EditElementViewModel: CellDictionaryViewModel {
    @Published var bufferCells: Dictionary<CellCoordinate, Bool>
    @Published var name: String
    
    init() {
        self.name = ""
        self.bufferCells = Dictionary<CellCoordinate, Bool>()
        super.init(time: 1, rowSize: 0, colSize: 0)
    }
    
    init(time: Float, rowSize: Int, colSize: Int) {
        self.name = ""
        self.bufferCells = Dictionary<CellCoordinate, Bool>()
        super.init(time: time, rowSize: rowSize, colSize: colSize)
    }
    
    required init(from decoder: Decoder) throws {
        self.name = ""
        self.bufferCells = Dictionary<CellCoordinate, Bool>()
        try super.init(from: decoder)
    }
    
    func defaultSave() -> Bool {
        let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let bundleID = Bundle.main.bundleIdentifier ?? "app.GameOfLife"
        let appSupportSubDirectory = applicationSupport.appendingPathComponent(bundleID,isDirectory: true)
        let savePath = appSupportSubDirectory.appendingPathComponent("saveCells", conformingTo: .directory)
        if !FileManager.default.fileExists(atPath: savePath.absoluteString) {
            print("Create folder")
            do {
                try FileManager.default.createDirectory(at: savePath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Cannot create folder")
                return false
            }
        }
        let path = savePath.appendingPathComponent(name, conformingTo: .json)
        print(path)
        return super.save(path: path.absoluteString)
    }
    
    func reset() {
        start = false
        cells = bufferCells
    }
    
    func saveToBuffer() {
        if start == false {
            bufferCells = super.cells
        }
    }
    
    var validate: Bool {
        name.isEmpty || rowSize <= 0 || colSize <= 0
    }
    
}
