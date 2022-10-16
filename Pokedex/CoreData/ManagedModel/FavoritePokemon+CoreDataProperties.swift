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

    @NSManaged public var date: Date?

}
