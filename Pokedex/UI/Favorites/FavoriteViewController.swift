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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as FavoriteTableViewCell
        return cell
    }
    
    
}
