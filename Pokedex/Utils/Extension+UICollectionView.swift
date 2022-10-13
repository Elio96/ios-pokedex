//
//  Extension+UICollectionView.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

extension UICollectionView {
    // register a custom collection view cell which conforms to ReusableView protocol
    func register<T: UICollectionViewCell>(_:T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    // dequeue a cell which conforms to ReusableView protocol
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}
