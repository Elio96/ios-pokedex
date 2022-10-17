//
//  Extension+UICollectionView.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

extension UICollectionView {
    
    static let footer = UICollectionView.elementKindSectionFooter
    
    func cell<Cell: UICollectionViewCell>(at indexPath: IndexPath) -> Cell {
        guard let cellItem = cellForItem(at: indexPath) as? Cell else {
            fatalError("Cell not found: \(Cell.self)")
        }
        return cellItem
    }
    // register a custom collection view cell which conforms to ReusableView protocol
    func register<T: UICollectionViewCell>(_:T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerForSupplementingViewOfKind<View: UICollectionReusableView>(view: View.Type) where View: ReusableView {
        guard let reusableViewKind = View.reusableViewKind else {
            fatalError("Could not register reusable view kind")
        }
        register(view.self, forSupplementaryViewOfKind: reusableViewKind, withReuseIdentifier: View.defaultReuseIdentifier)
    }
    
    // dequeue a cell which conforms to ReusableView protocol
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableView<View: UICollectionReusableView>(ofKind kind: String, at indexPath: IndexPath) -> View where View: ReusableView {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: View.defaultReuseIdentifier, for: indexPath) as? View else {
            fatalError("Could not dequeue reusable view")
        }
        return reusableView
    }
}

extension UICollectionReusableView {
    static let footer = UICollectionView.elementKindSectionFooter
    static let header = UICollectionView.elementKindSectionHeader
}
