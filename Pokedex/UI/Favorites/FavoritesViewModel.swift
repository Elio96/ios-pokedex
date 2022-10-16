//
//  FavoritesViewModel.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import UIKit

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
        favoriteManager.fetchFromStorage { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                if let favorites = favorites {
                    self.favoritesPokemons.value = favorites.compactMap({$0.toModel()})
                }
            case .failure(_):
                break
            }
        }
    }
    
    func numberOfRows() -> Int {
        return favoritesPokemons.value.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> PokemonModel {
        return favoritesPokemons.value[indexPath.row]
    }
    
    func selectItem(at indexPath: IndexPath, image: UIImage?) {
        let pokemon = favoritesPokemons.value[indexPath.row]
        coordinator?.startPokemonDetailViewController(with: pokemon, image: image)
    }
}
