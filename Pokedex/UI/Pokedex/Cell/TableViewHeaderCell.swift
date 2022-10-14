//
//  TableViewHeaderCell.swift
//  Pokedex
//
//  Created by Eliano Corallo on 14/10/22.
//

import UIKit

class TableViewHeaderCell: UIView {
    
    @ProgrammaticallyConstrained private var titleLabel: UILabel = UILabel()
    
    init(frame: CGRect = .zero, text: String?) {
        super.init(frame: frame)
        titleLabel.text = text
        titleLabel.edgeTo(view: self, topConstant: 4, bottomConstant: 4, rightConstant: 16, leftConstant: 16)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
