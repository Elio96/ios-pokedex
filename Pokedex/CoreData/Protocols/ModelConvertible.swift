//
//  ModelConvertible.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation

//Is used to convert a NSManagedObject to generic model
protocol ModelConvertible {
    associatedtype Model
    
    func toModel() -> Model?
}
