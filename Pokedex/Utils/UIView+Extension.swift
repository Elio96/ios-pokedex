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
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -leftConstant)
        ])
    }
}
