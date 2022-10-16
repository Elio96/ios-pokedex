//
//  Pokemon+CoreDataClass.swift
//  
//
//  Created by Eliano Corallo on 15/10/22.
//
//

import Foundation
import CoreData


public class Pokemon: NSManagedObject {

}

extension Pokemon: PokemonManagable {
    public var dateAdded: Date? {
       return nil
    }
    
    public static var entityName: String {
        return String(describing: self)
    }
    
}
