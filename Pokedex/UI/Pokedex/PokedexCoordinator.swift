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
        children = []
        setupNavigationController(navController: navigationController)
    }
    
    private func setupNavigationController(navController: UINavigationController) {
        self.navigationController = navController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.pokemonSolid?.withSize(25) as Any,
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.pokemonSolid?.withSize(20) as Any
        ]
    }
    
    func start() {
        let pokemonViewController = PokemonListViewController()
        let viewModel = PokemonViewModel()
        viewModel.coordinator = self
        pokemonViewController.viewModel = viewModel
        navigationController?.setViewControllers([pokemonViewController], animated: true)
    }
    
    private func buildPokemonDetailViewController(with pokemon: PokemonModel) -> PokemonDetailViewController {
        let pokemonDetailVC = PokemonDetailViewController()
        let pokemonDetailViewModel = PokemonDetailViewModel(from: pokemon)
        pokemonDetailVC.viewModel = pokemonDetailViewModel
        return pokemonDetailVC
    }
    
    func startPokemonDetailViewController(with pokemon: PokemonModel) {
        let pokemonDetailVC = buildPokemonDetailViewController(with: pokemon)
        self.navigationController?.pushViewController(pokemonDetailVC, animated: true)
    }
    
}
