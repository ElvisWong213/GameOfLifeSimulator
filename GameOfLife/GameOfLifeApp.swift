//
//  GameOfLifeApp.swift
//  GameOfLife
//
//  Created by Elvis on 15/06/2023.
//

import SwiftUI

@main
struct GameOfLifeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onDisappear() {
                    NSApplication.shared.terminate(self)
                }
        }
        .windowResizability(.contentSize)
    }
}
