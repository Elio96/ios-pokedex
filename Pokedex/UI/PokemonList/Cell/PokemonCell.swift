//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit
import Kingfisher

class PokemonCell: UICollectionViewCell, ReusableView {
    
    @ProgrammaticallyConstrained var pokeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    @ProgrammaticallyConstrained var pokemonTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        self.setupConstraints()
        dropShadow(color: .black.withAlphaComponent(0.7), opacity: 0.8, offSet: CGSize(width: 2, height: 2), radius: 4.0)
        contentView.roundCorners(cornerRadius: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(pokeImageView)
        contentView.addSubview(pokemonTitle)
        
        NSLayoutConstraint.activate([
            pokeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            pokeImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pokemonTitle.topAnchor.constraint(equalTo: pokeImageView.bottomAnchor),
            pokemonTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            pokemonTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            pokemonTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(pokemon: PokemonModel) {
        pokemonTitle.text = pokemon.name.capitalized
        if let pokeImageUrl = URL(string: pokemon.sprite.url) {
            pokeImageView.kf.setImage(with: ImageResource(downloadURL: pokeImageUrl, cacheKey: pokemon.sprite.url))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokeImageView.image = nil
    }
}
