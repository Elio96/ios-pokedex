//
//  PokemonCoreDataManager.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation
import CoreData

class PokemonCoreDataManager<T: NSManagedObject> where T: PokemonManagable{
    
    private var managedObjectContext: NSManagedObjectContext
    private var entityName: String
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.entityName = String(describing: T.self)
        self.managedObjectContext = managedObjectContext
    }
    
    func clearAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: T.self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try CoreDataManager.shared.persistentContainer
                .persistentStoreCoordinator
                .execute(
                    deleteRequest,
                    with: CoreDataManager.shared.managedObjectContext
                )
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension PokemonCoreDataManager: DataManagerDelegate {
    
    typealias CodableModel = PokemonModel
    
    typealias ManagedObject = T
    
    func saveToStorage(models: [CodableModel], desiredToConvert: PokemonManagable.Type) {
        models.convertToManagedObject(managedObjectContext, wantsToConvert: desiredToConvert)
        CoreDataManager.shared.saveContext()
    }
    
    func fetchFromStorage(completion: @escaping DataFetcherCompletion) {
        let pokemonFetchReq = NSFetchRequest<T>(entityName: entityName)
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
