//
//  TwoGroupView.swift
//  GameOfLife
//
//  Created by Elvis on 24/06/2023.
//

import SwiftUI

struct TwoGroupView: View {
    @StateObject var cellViewModel: Cell = TwoGroupCellViewModel(time: 0.1, rowSize: 50, colSize: 50)
    @State private var size: CGFloat = 10.0
    
    var body: some View {
        VStack {
            HStack() {
                GridView(cellSize: $size)
                    .environmentObject(cellViewModel)
                ChooseTeamView()
                    .environmentObject(cellViewModel as! TwoGroupCellViewModel)
            }
            ControlerView()
                .environmentObject(cellViewModel)
        }
        .onDisappear() {
            cellViewModel.start = false
        }
    }
}

struct TwoGroupView_Previews: PreviewProvider {
    static var previews: some View {
        TwoGroupView()
    }
}
