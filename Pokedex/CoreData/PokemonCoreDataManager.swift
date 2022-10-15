//
//  PokemonCoreDataManager.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation
import CoreData

class PokemonCoreDataManager {
    
    private var managedObjectContext: NSManagedObjectContext
    private var entityName: String
    
    init(managedObjectContext: NSManagedObjectContext, entityName: String) {
        self.entityName = entityName
        self.managedObjectContext = managedObjectContext
    }
}

extension PokemonCoreDataManager: DataManagerDelegate {
    
    typealias CodableModel = PokemonModel
    
    typealias ManagedObject = Pokemon
    
    func saveToStorage(models: [PokemonModel]) {
        models.convertToManagedObject(managedObjectContext)
        CoreDataManager.shared.saveContext()
    }
    
    func fetchFromStorage(completion: @escaping DataFetcherCompletion) {
        let pokemonFetchReq = NSFetchRequest<Pokemon>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        pokemonFetchReq.sortDescriptors = [sortDescriptor]
        do {
            let pokemons = try managedObjectContext.fetch(pokemonFetchReq)
            completion(.success(pokemons))
        } catch let error {
            completion(.failure(error))
            AlertHandler.show(title: "Errore", message: error.localizedDescription)
        }
    }
}
