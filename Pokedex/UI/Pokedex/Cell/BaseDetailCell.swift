//
//  BaseDetailCell.swift
//  Pokedex
//
//  Created by Eliano Corallo on 14/10/22.
//

import UIKit

struct BaseDetailItem {
    let title: String
    let value: String
}

class BaseDetailCell: UITableViewCell, ReusableView {
    
    @ProgrammaticallyConstrained private var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .gameBoyFont?.setSize(14)
        return label
    }()
    
    @ProgrammaticallyConstrained private var valuesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = .gameBoyFont?.setSize(12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(title)
        contentView.addSubview(valuesLabel)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            valuesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            valuesLabel.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 16),
            valuesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            valuesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with baseItem: BaseDetailItem) {
        title.text = baseItem.title
        valuesLabel.text = baseItem.value
    }
}
