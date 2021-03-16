//
//  PokemonDetailsModel.swift
//  Pokedex
//
//  Created by Andres Acevedo on 13.03.2021.
//

import Foundation

struct PokemonDetailsModel: Codable {
    var name: String
    var id: Int
    var sprites: SpritesPokemon
    var types: [SkillTypes]
    var stats: [StatsModel]
    var weight: Int
}

struct SkillTypes: Codable {
    var slot: Int
    var type: SkillType
}

struct SkillType: Codable {
    var name: String
    var url: String
}

struct MainImages: Codable {
    enum CodingKeys: String, CodingKey {
        case officialArt = "official-artwork"
    }
    var officialArt: OfficialArt
}

struct OfficialArt: Codable {
    var front_default: String
}

struct SpritesPokemon: Codable {
    var front_shiny: String
    var other: MainImages
}

struct StatsModel: Codable {
    var base_stat: Int
    var effort: Int
    var stat: StatModel
}

struct StatModel: Codable {
    var name: String
    var url: String
}
