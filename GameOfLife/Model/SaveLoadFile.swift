//
//  FileManager.swift
//  GameOfLife
//
//  Created by Elvis on 26/06/2023.
//

import Foundation

protocol SaveLoadFile {
    func save(path: String) -> Bool
    
    func load(path: String)
}
