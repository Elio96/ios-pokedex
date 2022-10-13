//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @ProgrammaticallyConstrained private var tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    private func setupTableView() {
        tableView.edgeTo(view: self.view)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
