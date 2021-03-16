//
//  PokemonSpeciesModel.swift
//  Pokedex
//
//  Created by Andres Acevedo on 15.03.2021.
//

import Foundation

struct PokemonSpeciesModel: Codable {
    var flavor_text_entries: [FlavorTextModel]
}

struct FlavorTextModel: Codable {
    var flavor_text: String
    var language: LanguageTextModel
    var version: VersionTextModel
}

struct LanguageTextModel: Codable {
    var name: String
    var url: String
}

struct VersionTextModel: Codable {
    var name: String
    var url: String
}
