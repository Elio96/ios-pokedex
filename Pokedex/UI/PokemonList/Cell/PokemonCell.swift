//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

class PokemonCell: UICollectionViewCell, ReusableView {
    
    @ProgrammaticallyConstrained var pokeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    @ProgrammaticallyConstrained var pokemonTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.setupConstraints()
        dropShadow(color: .black.withAlphaComponent(0.7), opacity: 0.3, offSet: CGSize(width: 2, height: 2), radius: 4.0)
        roundCorners(cornerRadius: 10)
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
        
    }
}
