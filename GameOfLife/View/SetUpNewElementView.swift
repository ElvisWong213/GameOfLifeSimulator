//
//  SetUpNewElementView.swift
//  GameOfLife
//
//  Created by Elvis on 05/07/2023.
//

import SwiftUI

struct SetUpNewElementView: View {
    @StateObject var editElementVM: EditElementViewModel = EditElementViewModel(time: 0.1, rowSize: 10, colSize: 10)
    @State var showAlert = false
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $editElementVM.name)
                TextField("Number of row", value: $editElementVM.rowSize, format: .number)
                TextField("Number of column", value: $editElementVM.colSize, format: .number)
            }
            HStack {
                NavigationLink("Create") {
                    EditElementView()
                        .environmentObject(editElementVM)
                }
                .disabled(editElementVM.validate)
                Button("Cancel") {
                    dismiss()
                }
            }
        }
        .padding()
    }
}

struct SetUpNewElementView_Previews: PreviewProvider {
    static var previews: some View {
        SetUpNewElementView()
//            .environmentObject(SetUpNewElementViewModel())
    }
}
