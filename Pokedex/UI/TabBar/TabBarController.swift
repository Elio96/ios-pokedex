//
//  TabBarController.swift
//  Pokedex
//
//  Created by Eliano Corallo on 12/10/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .pokeRed
        tabBar.isTranslucent = false
    }
    
}
