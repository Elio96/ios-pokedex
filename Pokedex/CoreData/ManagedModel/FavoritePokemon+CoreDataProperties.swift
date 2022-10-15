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
    @NSManaged public var weight: Int64
    @NSManaged public var height: Int64
    @NSManaged public var urlImage: String?
    @NSManaged public var name: String?
    @NSManaged public var types: NSObject?
    @NSManaged public var stats: NSObject?
    @NSManaged public var moves: NSObject?
    @NSManaged public var abilities: NSObject?

}
