//
//  Extension+UIFont.swift
//  Pokedex
//
//  Created by Eliano Corallo on 14/10/22.
//

import Foundation
import UIKit

extension UIFont {
    static let pokemonSolid = UIFont(name: "Pokemon Solid", size: 16)
    static let pokemonHollow = UIFont(name: "Pokemon Hollow", size: 16)
    static let gameBoyFont = UIFont(name: "Early GameBoy", size: 16)
    
    func setSize(_ size: CGFloat) -> UIFont{
        return self.withSize(size)
    }
}
