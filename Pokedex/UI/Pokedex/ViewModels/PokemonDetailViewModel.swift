//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Eliano Corallo on 14/10/22.
//

import Foundation
import Kingfisher

enum ItemCell {
    case detailCell(BaseDetailItem)
    case statisticCell(StatisticItem)
}

struct Section {
    var title: String? = nil
    var items: [ItemCell]
}

enum EventFavorite {
    case added
    case removed
}

class PokemonDetailViewModel {
    
    private var pokemonModel: PokemonModel
    
    var title: String {
        return pokemonModel.name.capitalized
    }
    
    var name: String {
        return pokemonModel.name
    }
    
    var imagePokemon: UIImage?
    
    var isBright: Bool {
        return imagePokemon?.averageColor?.isBright ?? false
    }
    
    func getPokemonImage() async -> UIImage? {
        if let url = URL(string: pokemonModel.sprite.url) {
            return await withCheckedContinuation({ continuation in
                KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: url, cacheKey: pokemonModel.sprite.url)) { result in
                    switch result {
                    case .success(let retreivedImage):
                        continuation.resume(returning: retreivedImage.image)
                    case .failure(let err):
                        AlertHandler.show(title: "Errore", message: err.localizedDescription)
                    }
                }
            })
        }
        return nil
    }
    
    var tableViewDataSource: [Section]
    
    private var favoriteManager: PokemonCoreDataManager<FavoritePokemon>
    
    init(from model: PokemonModel, imagePokemon: UIImage?) {
        self.pokemonModel = model
        tableViewDataSource = []
        self.imagePokemon = imagePokemon
        favoriteManager = PokemonCoreDataManager(managedObjectContext: CoreDataManager.shared.managedObjectContext)
    }
    
    func viewDidLoad() {
        let type: ItemCell = .detailCell(BaseDetailItem(title: "Type", value: pokemonModel.types.stringTypes))
        let weight: ItemCell = .detailCell(BaseDetailItem(title: "Weight", value: pokemonModel.weightString))
        let height: ItemCell = .detailCell(BaseDetailItem(title: "Height", value: pokemonModel.heightString))
        let abilities: ItemCell = .detailCell(BaseDetailItem(title: "Abilities", value: pokemonModel.abilities.stringAbilities))
        let moves: ItemCell = .detailCell(BaseDetailItem(title: "Moves", value: pokemonModel.moves.stringMoves))
        
        let sectionInfo = Section(title: "Details", items: [type, weight, height, abilities, moves])
        
        let statistics: [ItemCell] = pokemonModel.stats.map({
            .statisticCell(StatisticItem(statEnum: StatisticEnum.init(rawValue: $0.stat.name), baseStat: $0.baseStat))
        })
        
        let sectionStats = Section(title: "Statistics", items: statistics)
        
        tableViewDataSource.append(sectionInfo)
        tableViewDataSource.append(sectionStats)
    }
    
    var isFavoritePokemon: Bool {
        var contains: Bool = false
        favoriteManager.fetchFromStorage { [weak self] result in
            guard let self = self else { return }
            if case let .success(favorites) = result, let favs = favorites {
                if favs.contains(where: {$0.id == Int64(self.pokemonModel.id)}) {
                    contains = true
                }
            }
        }
        return contains
    }
    
    func handleFavoriteAction(completion: (EventFavorite) -> Void) {
        if !isFavoritePokemon {
            favoriteManager.saveToStorage(models: [pokemonModel], desiredToConvert: FavoritePokemon.self)
            completion(.added)
        } else {
            favoriteManager.clearById(pokemonModel.id)
            completion(.removed)
        }
    }
    
    func title(for section: Int) -> String? {
        return tableViewDataSource[section].title
    }
    
    func numberOfSection() -> Int {
        return tableViewDataSource.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return tableViewDataSource[section].items.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> ItemCell {
        return tableViewDataSource[indexPath.section].items[indexPath.row]
    }
    
}
