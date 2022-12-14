//
//  ImageAssets.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

enum ImageAssets: String {
    
    case selectedPokeball
    case unselectedPokeball
    case pokedexIcon
    case favoritePokemon
}

extension UIImage {
    convenience init?(imageAsset: ImageAssets) {
        self.init(named: imageAsset.rawValue)
    }
}
