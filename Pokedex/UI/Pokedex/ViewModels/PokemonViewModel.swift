//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import Foundation
import UIKit

final class PokemonViewModel {
    
    weak var coordinator: PokedexCoordinator?
    
    var pokemon: Box<[PokemonModel]> = Box([])
    
    var title: String {
        return "Pokedex"
    }
    
    //is a proprerty which can stop a series of network calls if loading is not completed
    private var inLoading: Bool = false
    
    func getPokemon() {
        guard !inLoading else { return }
        inLoading = true
        PokemonApiManager.shared.fetchPokemons { [weak self] result in
            guard let self = self else { return }
            self.inLoading = false
            switch result {
            case .success(let res):
                self.pokemon.value.append(contentsOf: res)
            case .failure(let error):
                AlertHandler.show(title: "Errore", message: error.localizedDescription)
            }
        }
    }
    
    func numberOfItemInSection() -> Int {
        return pokemon.value.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> PokemonModel {
        return pokemon.value[indexPath.row]
    }
    
    func selectItem(at indexPath: IndexPath, image: UIImage?) {
        let pokemon = pokemon.value[indexPath.row]
        coordinator?.startPokemonDetailViewController(with: pokemon, image: image)
    }
}
