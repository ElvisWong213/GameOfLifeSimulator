//
//  ContentView.swift
//  GameOfLife
//
//  Created by Elvis on 15/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView(
            sidebar: {
                List() {
                    Section(header: Text("Game mode")) {
                        NavigationLink {
                            BasicView()
                        } label: {
                            Label("Basic", systemImage: "app.fill")
                                .font(.title3)
                        }
                        NavigationLink {
                            TwoGroupView()
                        } label: {
                            Label("Two Group", systemImage: "app.fill")
                                .font(.title3)
                        }
                    }
                    Section(header: Text("Library")) {
                        NavigationLink {
                            LibraryView()
                        } label: {
                            Label("Library", systemImage: "books.vertical.fill")
                                .font(.title3)
                        }
                    }
                }
            }, detail: {
                Text("Please select mode")
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
