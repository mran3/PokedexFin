//
//  PokenListModel.swift
//  Pokedex
//
//  Created by Andres Acevedo on 13.03.2021.
//

import Foundation

struct ListModel: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [PokemonListModel]
}

struct PokemonListModel: Codable {
    let name: String
    let url: String
}
