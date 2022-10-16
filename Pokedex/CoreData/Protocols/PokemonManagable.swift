//
//  PokemonManagable.swift
//  Pokedex
//
//  Created by Eliano Corallo on 16/10/22.
//

import Foundation

@objc public protocol PokemonManagable{
    var id: Int64 { get set }
    var name: String? { get set }
    var weight: Int64 { get set }
    var height: Int64 { get set }
    var urlImage: String? { get set }
    var abilities: PokemonAttributeCoreData? { get set }
    var moves: PokemonAttributeCoreData? { get set }
    var types: PokemonAttributeCoreData? { get set }
    var stats: PokemonAttributeCoreData? { get set }
    var dateAdded: Date? { get set }
    
    var entityName: String { get }
}
