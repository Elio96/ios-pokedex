//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Eliano Corallo on 13/10/22.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var viewModel: PokemonDetailViewModel!
    
    @ProgrammaticallyConstrained private var detailView: UIView = {
        let view = UIView()
        return view
    }()
    
    @ProgrammaticallyConstrained private var pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    @ProgrammaticallyConstrained private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.alwaysBounceVertical = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .white
        setupConstraints()
        setupTableView()
        viewModel.viewDidLoad()
        Task {
            await self.setupUI()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BaseDetailCell.self)
        tableView.register(StatisticCell.self)
    }
    
    private func setupUI() async{
        detailView.backgroundColor = .white
        let image = await viewModel.getPokemonImage()
        pokemonImage.image = image
        view.backgroundColor = image?.averageColor
    }
    
    private func setupConstraints() {
        self.view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6),
            detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            detailView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
        self.view.addSubview(pokemonImage)
        NSLayoutConstraint.activate([
            pokemonImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            pokemonImage.heightAnchor.constraint(equalTo: pokemonImage.widthAnchor),
            pokemonImage.centerYAnchor.constraint(equalTo: self.detailView.topAnchor, constant: -25),
            pokemonImage.centerXAnchor.constraint(equalTo: self.detailView.centerXAnchor),
            pokemonImage.leftAnchor.constraint(greaterThanOrEqualTo: self.view.leftAnchor),
            pokemonImage.rightAnchor.constraint(lessThanOrEqualTo: self.view.rightAnchor),
        ])
        
        tableView.edgeTo(view: detailView, topConstant: 16, bottomConstant: 16, rightConstant: 16, leftConstant: 16)
    }
    

}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSource = viewModel.cellForRow(at: indexPath)
        switch dataSource {
        case .detailCell(let baseDetailItem):
            let cell = tableView.dequeueReusableCell(for: indexPath) as BaseDetailCell
            cell.configure(with: baseDetailItem)
            return cell
        case .statisticCell(let statisticItem):
            return UITableViewCell()
        }
    }
    
    
}
