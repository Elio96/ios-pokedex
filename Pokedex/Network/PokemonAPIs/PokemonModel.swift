//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import Foundation
import CoreData

typealias Types = [Type]
typealias Abilities = [Ability]
typealias Moves = [Move]

typealias PokemonsModel = [PokemonModel]

struct PokemonModel: Decodable {
    let id: Int
    let name: String
    let weight: Int
    let height: Int
    var baseExperience: Int = 0
    var sprite: Sprite
    var abilities: Abilities
    var moves: Moves
    var types: Types
    var stats: [Stat]
    
    private enum CodingKeys: String, CodingKey {
        case id, name, weight, height, abilities, moves, types, stats
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


//Pokemon Model Core Data
extension PokemonModel: ManagedObjectConvertible {
    
    typealias ManagedObject = Pokemon
    
    @discardableResult
    func toManagedObject(in context: NSManagedObjectContext) -> Pokemon? {
        let entityName = Pokemon.entityName
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("Can't create entity \(entityName)")
            return nil
        }
        let object = Pokemon(entity: entityDescription, insertInto: context)
        object.id = Int64(id)
        object.name = name
        object.weight = Int64(weight)
        object.height = Int64(height)
        let abilities: [AttributeCoreData] = self.abilities.map({AttributeCoreData(name: $0.ability.name, url: $0.ability.url)})
        object.abilities = PokemonAttributeCoreData(attributes: abilities)
        object.urlImage = sprite.url
        let moves: [AttributeCoreData] = self.moves.map({AttributeCoreData(name: $0.move.name, url: $0.move.url)})
        object.moves = PokemonAttributeCoreData(attributes: moves)
        let types: [AttributeCoreData] = self.types.map({AttributeCoreData(name: $0.type.name, url: $0.type.url)})
        object.types = PokemonAttributeCoreData(attributes: types)
        let stats: [AttributeCoreData] = self.stats.map({AttributeCoreData(name: $0.stat.name, url: $0.stat.url, baseStat: $0.baseStat)})
        object.stats = PokemonAttributeCoreData(attributes: stats)
        return object
    }
}

extension PokemonsModel {
    
    func convertToManagedObject(_ managedObjectContext: NSManagedObjectContext) {
        forEach { $0.toManagedObject(in: managedObjectContext) }
    }
}
