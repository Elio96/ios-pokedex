//
//  ManagedObjectConvertible.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation
import CoreData

//Is used to convert a generic model to NSManagedObject
protocol ManagedObjectConvertible {
    associatedtype ManagedObject
    
    func toManagedObject(in context: NSManagedObjectContext, wantsToConvert: ManagedObject) -> ManagedObject?
}
