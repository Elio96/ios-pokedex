//
//  ReusableView.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
