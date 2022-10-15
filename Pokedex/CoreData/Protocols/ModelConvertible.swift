//
//  ModelConvertible.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation

protocol ModelConvertible {
    associatedtype Model
    
    func toModel() -> Model?
}
