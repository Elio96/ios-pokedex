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
    
    private var viewModel = PokemonViewModel()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .white
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        title = viewModel.title
        viewModel.viewDidLoad()
        setupCollectionView()
        viewModel.pokemon.bind { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.edgeTo(view: self.view)
        collectionView.register(PokemonCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
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
}

