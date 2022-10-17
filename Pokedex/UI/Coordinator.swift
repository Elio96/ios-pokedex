//
//  Coordinator.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    
    func start()
}
