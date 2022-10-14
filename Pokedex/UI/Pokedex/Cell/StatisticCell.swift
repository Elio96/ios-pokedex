//
//  StatisticCell.swift
//  Pokedex
//
//  Created by Eliano Corallo on 14/10/22.
//

import UIKit

enum StatisticEnum: String {
    case hp = "hp"
    case spatk = "special-attack"
    case atk = "attack"
    case spdef = "special-defense"
    case def = "defense"
    case speed = "speed"
    
    var title: String {
        switch self {
        case .hp:
            return "Hp"
        case .spatk:
            return "Sp.Atk"
        case .atk:
            return "Atk"
        case .spdef:
            return "Sp.Def"
        case .def:
            return "Def"
        case .speed:
            return "Speed"
        }
    }
    
    var color: UIColor {
        switch self {
        case .hp:
            return .purple
        case .spatk:
            return .orange
        case .atk:
            return .red
        case .spdef:
            return .blue
        case .def:
            return .cyan
        case .speed:
            return .green
        }
    }
}

struct StatisticItem {
    let statEnum: StatisticEnum?
    let baseStat: Int
}

class StatisticCell: UITableViewCell, ReusableView {
    
    @ProgrammaticallyConstrained private var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    
    @ProgrammaticallyConstrained private var statusValueRatio: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = label.font.withSize(15)
        return label
    }()
    
    @ProgrammaticallyConstrained private var statusBar: StatusBar = StatusBar()
    
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
        contentView.addSubview(statusBar)
        statusBar.addSubview(statusValueRatio)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            statusBar.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            statusBar.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 16),
            statusBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            statusValueRatio.centerXAnchor.constraint(equalTo: statusBar.centerXAnchor),
            statusValueRatio.topAnchor.constraint(equalTo: statusBar.topAnchor, constant: 2),
            statusValueRatio.bottomAnchor.constraint(equalTo: statusBar.bottomAnchor, constant: -2)
        ])
    }
    
    func configure(with statistic: StatisticItem) {
        title.text = statistic.statEnum?.title.uppercased()
        if let isBright = statistic.statEnum?.color.isBright {
            statusValueRatio.textColor = isBright ? .black : .white
        }
        statusValueRatio.text = "\(statistic.baseStat)/\(max(statistic.baseStat, 100))"
        statusBar.configure(with: statistic)
    }
}
