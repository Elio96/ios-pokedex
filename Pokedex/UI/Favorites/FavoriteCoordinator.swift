//
//  FavoriteCoordinator.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import UIKit

class FavoriteCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
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
            .font: UIFont.gameBoyFont?.withSize(25) as Any,
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.pokemonSolid?.withSize(20) as Any
        ]
    }
    
    func start() {
        let favoriteVC = FavoriteViewController()
        let favoritesViewModel = FavoritesViewModel(coordinator: self)
        favoriteVC.viewModel = favoritesViewModel
        navigationController?.setViewControllers([favoriteVC], animated: true)
    }
    
}
