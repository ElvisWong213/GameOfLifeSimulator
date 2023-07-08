//
//  EditElementView.swift
//  GameOfLife
//
//  Created by Elvis on 05/07/2023.
//

import SwiftUI

struct EditElementView: View {
    @State private var cellSize: CGFloat = 10
    @EnvironmentObject var editElementVM: EditElementViewModel
    @State private var saveState = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            GridView(cellSize: $cellSize)
                .environmentObject(editElementVM as Cell)
            HStack {
                Button("Clear") {
                    editElementVM.start = false
                    editElementVM.clear()
                }
                Button("Reset") {
                    editElementVM.reset()
                }
                Button(editElementVM.start ? "Stop" : "Start") {
                    editElementVM.saveToBuffer()
                    editElementVM.start.toggle()
                    editElementVM.performUpdateCell()
                }
            }
            Button("Save") {
                editElementVM.start = false
                saveState = editElementVM.defaultSave()
                showAlert.toggle()
            }
            .alert(saveState ? "Save suscefully" : "Unable to save", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

struct EditElementView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var cell = EditElementViewModel(time: 0.1, rowSize: 10, colSize: 10)
        EditElementView()
            .environmentObject(cell as Cell)
    }
}
