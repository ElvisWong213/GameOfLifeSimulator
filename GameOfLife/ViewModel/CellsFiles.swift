//
//  CellsFiles.swift
//  GameOfLife
//
//  Created by Elvis on 09/07/2023.
//

import Foundation

struct FileProperty: Hashable, Identifiable {
    let id = UUID()
    var name: String
    var path: URL
}

class CellsFiles: ObservableObject {
    @Published var files: [FileProperty]
    @Published var selectedFile: UUID?
    
    init() {
        self.files = []
        self.selectedFile = nil
    }
    
    func getSaveDirectory() -> URL {
        let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let bundleID = Bundle.main.bundleIdentifier ?? "app.GameOfLife"
        let appSupportSubDirectory = applicationSupport.appendingPathComponent(bundleID, isDirectory: true)
        let savePath = appSupportSubDirectory.appendingPathComponent("saveCells", conformingTo: .directory)
        return savePath
    }
    
    func loadFile() {
        self.files.removeAll()
        do {
            let savePath = getSaveDirectory()
            let dirEnum = try FileManager.default.contentsOfDirectory(at: savePath, includingPropertiesForKeys: [.nameKey])
            for file in dirEnum {
                var name = file.lastPathComponent
                name.replace(".json", with: "")
                files.append(FileProperty(name: name, path: file))
            }
        } catch {
            print("Error")
        }
    }
    
    func removeFile() {
        if selectedFile == nil {
            print("Selection is nil")
            return
        }
        let removeFlie = files.filter { $0.id == selectedFile }
        guard let removeFliePath = removeFlie.first?.path else {
            print("element does not exist")
            return
        }
        do {
            try FileManager.default.removeItem(at: removeFliePath)
        } catch {
            print("Cannot remove file")
        }
    }
}
