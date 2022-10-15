//
//  Pokemon+CoreDataProperties.swift
//  
//
//  Created by Eliano Corallo on 15/10/22.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var weight: Int64
    @NSManaged public var height: Int64
    @NSManaged public var urlImage: String?
    @NSManaged public var abilities: AbilitiesAttributeCoreData?
    @NSManaged public var moves: NSObject?
    @NSManaged public var types: NSObject?
    @NSManaged public var stats: NSObject?
    
    static let entityName = "Pokemon"

}

extension Pokemon: ModelConvertible {
    func toModel() -> PokemonModel? {
        guard let abilities = self.abilities?.abilities?.map({Ability.init(ability: ItemResp.init(name: $0.name ?? "", url: $0.url ?? ""))}) else { return nil }
        return PokemonModel(
            id: Int(id),
            name: name ?? "",
            weight: Int(weight),
            height: Int(height),
            abilities: abilities
        )
    }
}
