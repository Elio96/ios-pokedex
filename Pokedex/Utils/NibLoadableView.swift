//
//  NibLoadableView.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import UIKit

//this protocol is used to load the xib file without indicate the nib name
protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
