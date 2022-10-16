//
//  FavoritePokemon+CoreDataProperties.swift
//  
//
//  Created by Eliano Corallo on 16/10/22.
//
//

import Foundation
import CoreData


extension FavoritePokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePokemon> {
        return NSFetchRequest<FavoritePokemon>(entityName: "FavoritePokemon")
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var weight: Int64
    @NSManaged public var height: Int64
    @NSManaged public var urlImage: String?
    @NSManaged public var abilities: PokemonAttributeCoreData?
    @NSManaged public var moves: PokemonAttributeCoreData?
    @NSManaged public var types: PokemonAttributeCoreData?
    @NSManaged public var stats: PokemonAttributeCoreData?
    @NSManaged public var dateAdded: Date?

}

extension FavoritePokemon: PokemonManagable {
    
    public var entityName: String {
        return String(describing: self)
    }
}

extension FavoritePokemon: ModelConvertible {
    func toModel() -> PokemonModel? {
        guard let abilities = self.abilities?.attributes?.map({Ability.init(ability: ItemResp.init(name: $0.name ?? "", url: $0.url ?? ""))}),
              let types = self.types?.attributes?.map({Type.init(type: ItemResp.init(name: $0.name ?? "", url: $0.url ?? ""))}),
              let moves = self.moves?.attributes?.map({Move.init(move: ItemResp.init(name: $0.name ?? "", url: $0.url ?? ""))}),
              let stats = self.stats?.attributes?.map({Stat.init(baseStat: $0.baseStat ?? 0, stat: ItemResp.init(name: $0.name ?? "", url: $0.url ?? ""))})
        else { return nil }
        return PokemonModel(
            id: Int(id),
            name: name ?? "",
            weight: Int(weight),
            height: Int(height),
            sprite: Sprite(url: urlImage ?? ""),
            abilities: abilities,
            moves: moves,
            types: types,
            stats: stats
        )
    }
}
