//
//  LibraryView.swift
//  GameOfLife
//
//  Created by Elvis on 05/07/2023.
//

import SwiftUI

struct LibraryView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Library()
                HStack {
                    NavigationLink("Add") {
                        SetUpNewElementView()
                    }
                    Button("Remove") {
                        
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
