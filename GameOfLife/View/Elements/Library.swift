//
//  Library.swift
//  GameOfLife
//
//  Created by Elvis on 28/06/2023.
//

import SwiftUI

struct FileProperty: Hashable, Identifiable {
    let id = UUID()
    var name: String
    var path: URL
}

struct Library: View {
    @State private var files: [FileProperty] = []
    @State private var selectedFile: UUID?
    
    var body: some View {
        VStack {
            List(files, selection: $selectedFile) {
                Text($0.name)
            }
        }
        .onAppear() {
            do {
                let applicationSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
                let bundleID = Bundle.main.bundleIdentifier ?? "app.GameOfLife"
                let appSupportSubDirectory = applicationSupport.appendingPathComponent(bundleID, isDirectory: true)
                let savePath = appSupportSubDirectory.appendingPathComponent("saveCells", conformingTo: .directory)
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
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
