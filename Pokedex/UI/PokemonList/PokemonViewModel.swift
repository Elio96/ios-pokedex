//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import Foundation

final class PokemonViewModel {
    
    var pokemon: Box<[PokemonModel]> = Box([])
    
    func viewDidLoad() {
        getPokemon()
    }
    
    var title: String {
        return "Pokedex"
    }
    
    private func getPokemon() {
        PokemonApiManager.shared.fetchPokemons { [weak self] result in
            guard let self = self else { return }
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
}
