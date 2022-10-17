//
//  LoaderCell.swift
//  Pokedex
//
//  Created by Eliano Corallo on 14/10/22.
//

import UIKit

class LoaderCell: UICollectionReusableView, ReusableView {
    
    static var reusableViewKind: String? {
        return Self.footer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configure(with loader: Loader) {
        addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loader.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            loader.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

