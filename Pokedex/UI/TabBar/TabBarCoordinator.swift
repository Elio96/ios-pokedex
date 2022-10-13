//
//  TabBarCoordinator.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import Foundation
import UIKit

enum TabBarPage {
    case pokemonList
    case favorites
    
    init?(index: Int) {
        switch index {
        case 0: self = .pokemonList
        case 1: self = .favorites
        default: return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .pokemonList:
            return "Pokedex"
        case .favorites:
            return "Favorites"
        }
    }
    
    func pageImage(selected: Bool) -> UIImage? {
        let image: UIImage?
        switch self {
        case .pokemonList:
            image = selected ? .init(imageAsset: .selectedPokeball) : .init(imageAsset: .unselectedPokeball)
        case .favorites:
            image = selected ? .init(imageAsset: .selectedPokeball) : .init(imageAsset: .unselectedPokeball)
        }
        return image
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .pokemonList:
            return 0
        case .favorites:
            return 1
        }
    }
}

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: TabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabBarCoordinator: TabCoordinatorProtocol {
    var tabBarController: TabBarController
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    var pokedexCoordinator: PokedexCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController = TabBarController()
    }
    
    func start() {
        self.setupPages()
    }
    
    private func setupPages() {
        let pages: [TabBarPage] = [.pokemonList, .favorites].sorted(by: {$0.pageOrderNumber() < $1.pageOrderNumber()})
        let controllers: [UINavigationController] = pages.map({getTabBarController($0)})
        prepareTabBarController(withTabControllers: controllers)
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage(index: index) else { return }
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func currentPage() -> TabBarPage? {
        TabBarPage(index: tabBarController.selectedIndex)
    }
    
    private func getTabBarController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        switch page {
        case .pokemonList:
            pokedexCoordinator = PokedexCoordinator(navigationController: navController)
            guard let pokedexCoordinator = pokedexCoordinator else {
                return navController
            }

            pokedexCoordinator.parentCoordinator = self
            pokedexCoordinator.start()
            children.append(pokedexCoordinator)
        case .favorites:
//            profileCoordinator = ProfileCoordinator(navigationController: navController)
//            guard let profileCoordinator = profileCoordinator else {
//                return navController
//            }
//            profileCoordinator.start()
//            profileCoordinator.parentCoordinator = self
//            children.append(profileCoordinator)
            break
        }
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(), image: page.pageImage(selected: false), selectedImage: page.pageImage(selected: true))
        return navController
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.pokemonList.pageOrderNumber()
        navigationController?.viewControllers = [tabBarController]
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in children.enumerated() where coordinator === child {
            children.remove(at: index)
            break
        }
    }
}
