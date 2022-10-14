//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Eliano Corallo on 12/10/22.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    @ProgrammaticallyConstrained private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.pokemonLayout)
        return collectionView
    }()
    
    @ProgrammaticallyConstrained private var loader: Loader = Loader()
    
    var viewModel: PokemonViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        title = viewModel.title
        viewModel.getPokemon()
        setupCollectionView()
        loader.animate()
        viewModel.pokemon.bind { [weak self] pokemons in
            DispatchQueue.main.async {
                if !pokemons.isEmpty {
                    self?.loader.stop()
                }
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.edgeTo(view: self.view)
        collectionView.register(PokemonCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerForSupplementingViewOfKind(view: LoaderCell.self)
    }

}

extension PokemonListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as PokemonCell
        cell.configure(pokemon: viewModel.cellForItemAt(indexPath: indexPath))
        return cell
    }
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width - 60) / 2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableView(ofKind: kind, at: indexPath) as LoaderCell
        footer.configure(with: loader)
        return footer
    }
}

extension PokemonListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        
        if distanceFromBottom < (height * 1.5) {
            self.loader.animate() 
            viewModel.getPokemon()
        }
    }
}

