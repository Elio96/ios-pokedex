//
//  NibLoadableView.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import UIKit

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
