//
//  UICollectionViewFlowLayout.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

extension UICollectionViewFlowLayout {
    static var pokemonLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 20.0
        layout.minimumLineSpacing = padding
        ReachabilityHandler.isReachable { _ in
            layout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        }
//        layout.minimumInteritemSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding , bottom: padding, right: padding )
        return layout
    }
}
