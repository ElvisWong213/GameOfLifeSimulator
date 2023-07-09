//
//  Library.swift
//  GameOfLife
//
//  Created by Elvis on 28/06/2023.
//

import SwiftUI

struct CellsLibrary: View {
    @EnvironmentObject var cellsFile: CellsFiles
    
    var body: some View {
        VStack {
            List(cellsFile.files, selection: $cellsFile.selectedFile) {
                Text($0.name)
            }
        }
        .onAppear() {
            cellsFile.loadFile()
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        CellsLibrary()
            .environmentObject(CellsFiles())
    }
}
