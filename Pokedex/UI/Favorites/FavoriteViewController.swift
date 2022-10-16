//
//  FavoriteViewController.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @ProgrammaticallyConstrained private var tableView = UITableView()
    
    var viewModel: FavoritesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = viewModel.title
        setupTableView()
        viewModel.favoritesPokemons.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavorites()
    }
    
    private func setupTableView() {
        tableView.edgeTo(view: self.view)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        tableView.register(FavoriteTableViewCell.self)
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemonModel = viewModel.cellForRowAt(indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(for: indexPath) as FavoriteTableViewCell
        cell.configure(with: pokemonModel)
        return cell
    }
    
    
}
