//
//  TabBarController.swift
//  Pokedex
//
//  Created by Eliano Corallo on 12/10/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    static func instantiate() -> TabBarController {
        let tabBarController = TabBarController()
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = .orange
        tabBarController.tabBar.isTranslucent = false
        
        let pokemonListViewController = UINavigationController(rootViewController: PokemonListViewController())
        pokemonListViewController.title = "Pokemons"
        
        tabBarController.viewControllers = [pokemonListViewController]
        
        return tabBarController
    }
}
