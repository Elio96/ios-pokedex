//
//  PokedexCoordinator.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

class PokedexCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var children: [Coordinator]
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        children = []
    }
    
    func start() {
        let pokemonViewController = PokemonListViewController()
        pokemonViewController.viewModel = PokemonViewModel()
        navigationController?.setViewControllers([pokemonViewController], animated: true)
    }
    
    
}
