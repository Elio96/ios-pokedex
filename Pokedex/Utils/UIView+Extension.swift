//
//  UIView+Extension.swift
//  Pokedex
//
//  Created by Eliano Corallo on 12/10/22.
//

import UIKit

extension UIView {
    
    func edgeTo(view: UIView, topConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, leftConstant: CGFloat = 0) {
        view.addSubview(self)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomConstant),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -rightConstant),
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftConstant)
        ])
    }
    
    @discardableResult
    func roundCorners(cornerRadius: CGFloat) -> Self {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        return self
    }
    
    @discardableResult
    func dropShadow() -> Self {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        return self
    }
    
    @discardableResult
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) -> Self {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        return self
    }
}
