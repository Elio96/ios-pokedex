//
//  ReusableView.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

//is a protocol which define the defaultReuseIdentifier
protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
    
    static var reusableViewKind: String? { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
    static var reusableViewKind: String? {
        if self is UICollectionReusableView.Type {
            fatalError("reusableViewKind not overwritten in \(self.defaultReuseIdentifier)")
        }
        return nil
    }
}
