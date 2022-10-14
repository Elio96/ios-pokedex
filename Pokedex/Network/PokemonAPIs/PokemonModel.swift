//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import Foundation

typealias Types = [Type]
typealias Abilities = [Ability]
typealias Moves = [Move]

struct PokemonModel: Decodable {
    let id: Int
    let name: String
    let weight: Int
    let height: Int
    let baseExperience: Int
    let forms: [ItemResp]
    let sprite: Sprite
    let abilities: Abilities
    let moves: Moves
    let types: Types
    let stats: [Stat]
    
    private enum CodingKeys: String, CodingKey {
        case id, name, weight, height, forms, abilities, moves, types, stats
        case baseExperience = "base_experience"
        case sprite = "sprites"
    }
}

struct Sprite: Decodable {
    let url: String
    
    private enum CodingKeys: String, CodingKey {
        case url = "front_default"
    }
}

struct Ability: Decodable {
    let ability: ItemResp
}

struct Move: Decodable {
    let move: ItemResp
}

struct Type: Decodable {
    let type: ItemResp
}

struct Stat: Decodable {
    let baseStat: Int
    let stat: ItemResp
    
    private enum CodingKeys: String, CodingKey {
        case stat
        case baseStat = "base_stat"
    }
}

extension Types {
    var stringTypes: String {
        map { $0.type.name.withoutDash }.joined(separator: "\n\n")
    }
}

extension Abilities {
    var stringAbilities: String {
        map { $0.ability.name.withoutDash }.joined(separator: "\n\n")
    }
}

extension Moves {
    var stringMoves: String {
        map { $0.move.name.withoutDash }.prefix(10).joined(separator: "\n\n")
    }
}

extension PokemonModel {
    var weightString: String {
        String(format: "%.1f kg", Double(weight) / 10.0)
    }
    
    var heightString: String {
        String(format: "%.1f m", Double(height) / 10.0)
    }
}
