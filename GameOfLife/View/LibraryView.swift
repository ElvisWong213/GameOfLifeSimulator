//
//  LibraryView.swift
//  GameOfLife
//
//  Created by Elvis on 05/07/2023.
//

import SwiftUI

struct LibraryView: View {
    @StateObject var cellsFiles = CellsFiles()
    
    var body: some View {
        NavigationStack {
            VStack {
                CellsLibrary()
                    .environmentObject(cellsFiles)
                HStack {
                    NavigationLink("Add") {
                        SetUpNewElementView()
                    }
                    Button("Remove") {
                        cellsFiles.removeFile()
                        cellsFiles.loadFile()
                    }
                }
                .padding()
            }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
