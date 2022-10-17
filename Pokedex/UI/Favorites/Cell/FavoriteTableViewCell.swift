//
//  FavoriteTableViewCell.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    private var downloadImageTask: DownloadTask?
    private var pokemon: PokemonModel?
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var secondType: UILabel!
    @IBOutlet weak var firstType: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        secondType.isHidden = true
        contentView.dropShadow(color: .black.withAlphaComponent(0.7), opacity: 0.8, offSet: CGSize(width: 2, height: 2), radius: 4.0)
        container.roundCorners(cornerRadius: 10)
    }
    
    func configure(with pokemon: PokemonModel) {
        self.pokemon = pokemon
        pokemonName.text = pokemon.name
        if pokemon.types.count < 2 {
            firstType.text = pokemon.types[0].type.name
        } else {
            firstType.text = pokemon.types[0].type.name
            secondType.text = pokemon.types[1].type.name
            secondType.isHidden = false
        }
        performDownloadImage()
    }
    
    private func performDownloadImage() {
        if let pokemon = pokemon, let url = URL(string: pokemon.sprite.url) {
            self.downloadImageTask = KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: url, cacheKey: pokemon.sprite.url)) { [weak self] result in
                switch result {
                case .success(let retreivedImage):
                    self?.pokemonImage.image = retreivedImage.image
                    guard let imageDominantColor = retreivedImage.image.averageColor else { return }
                    self?.container.backgroundColor = imageDominantColor
                    let colorText: UIColor = imageDominantColor.isBright ? .black : .white
                    self?.pokemonName.textColor = colorText
                    self?.setupLabel(label: self?.firstType, with: colorText)
                    self?.setupLabel(label: self?.secondType, with: colorText)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    private func setupLabel(label: UILabel?, with color: UIColor?) {
        label?.apply { it in
            it.addBorder(borderColor: color)
            it.roundCorners(cornerRadius: it.frame.height / 2)
            it.textColor = color
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.pokemonImage.image = nil
        self.firstType.text = ""
        self.secondType.isHidden = true
    }
}
