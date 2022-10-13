//
//  PokemonsResponse.swift
//  Pokedex
//
//  Created by Eliano Corallo on 12/10/22.
//

import Foundation

struct PokemonsResponse: Decodable {
    let next: String
    let results: PokemonItems
}

typealias PokemonItems = [ItemResp]

struct ItemResp: Decodable {
    let name: String
    let url: String
}
