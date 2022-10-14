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
    
}
