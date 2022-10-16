//
//  DataManagerDelegate.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation
import CoreData

protocol DataManagerDelegate where ManagedObject: NSManagedObject, ManagedObject: PokemonManagable {
    associatedtype CodableModel
    associatedtype ManagedObject
    
    typealias DataFetcherCompletion = (Result<[ManagedObject]?, Error>) -> Void

    func saveToStorage(models: [CodableModel])
    func saveToStorage(models: [CodableModel], desiredToConvert: PokemonManagable.Type)
    func fetchFromStorage(completion: @escaping DataFetcherCompletion)
}

extension DataManagerDelegate {
    func saveToStorage(models: [CodableModel]) {}
}
