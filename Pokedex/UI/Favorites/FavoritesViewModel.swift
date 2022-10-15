//
//  FavoritesViewModel.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import Foundation

class FavoritesViewModel {
    weak var coordinator: FavoriteCoordinator?
    
    private var favoriteManager: PokemonCoreDataManager<FavoritePokemon>
    
    var favoritesPokemons: Box<[PokemonModel]> = Box([])
    
    var title: String {
        return "Favorites"
    }
    
    init(coordinator: FavoriteCoordinator) {
        self.coordinator = coordinator
        favoriteManager = PokemonCoreDataManager(managedObjectContext: CoreDataManager.shared.managedObjectContext)
    }
    
    func fetchFavorites() {
        favoriteManager.fetchFromStorage { result in
            switch result {
            case .success(let favorites):
                break
            case .failure(let error):
                break
            }
        }
    }
}
