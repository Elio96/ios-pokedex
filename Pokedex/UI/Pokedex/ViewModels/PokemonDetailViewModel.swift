//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Eliano Corallo on 14/10/22.
//

import Foundation

enum ItemCell {
    case detailCell(BaseDetailItem)
    case statisticCell(StatisticItem)
}

struct Section {
    var title: String? = nil
    var items: [ItemCell]
}

class PokemonDetailViewModel {
    
    private var pokemonModel: PokemonModel
    
    var title: String {
        return pokemonModel.name.capitalized
    }
    
    init(from model: PokemonModel) {
        self.pokemonModel = model
    }
    
    func viewDidLoad() {
        let type: ItemCell = .detailCell(BaseDetailItem(title: "Type", value: pokemonModel.types.stringTypes))
        let weight: ItemCell = .detailCell(BaseDetailItem(title: "Weight", value: pokemonModel.weightString))
        let height: ItemCell = .detailCell(BaseDetailItem(title: "Height", value: pokemonModel.heightString))
        
    }
}
