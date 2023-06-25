//
//  ChooseTeamView.swift
//  GameOfLife
//
//  Created by Elvis on 24/06/2023.
//

import SwiftUI

struct ChooseTeamView: View {
    @EnvironmentObject var cellViewModel: TwoGroupCellViewModel
    
    var body: some View {
        VStack {
            Button("Blue") {
                cellViewModel.changeTeam(team: .Host)
            }
            .background(cellViewModel.team == .Host ? .blue : .clear)
            Button("Red") {
                cellViewModel.changeTeam(team: .Guest)
            }
            .background(cellViewModel.team == .Guest ? .red : .clear)
        }
        .fixedSize()
    }
}

struct ChooseTeamView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var cell = TwoGroupCellViewModel(time: 0.1, rowSize: 50, colSize: 50)
        ChooseTeamView()
            .environmentObject(cell)
    }
}
