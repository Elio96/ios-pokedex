//
//  ManagedObjectConvertible.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation
import CoreData

protocol ManagedObjectConvertible {
    associatedtype ManagedObject
    
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}
