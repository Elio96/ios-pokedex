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
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // this is used to avoid navigation title shrinking when table view is scrolling
    @ProgrammaticallyConstrained private var placeholderView: UIView = UIView()
    
    private var originalFavTintColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .init(imageAsset: .favoritePokemon), landscapeImagePhone: .init(imageAsset: .favoritePokemon), style: .plain, target: self, action: #selector(handleAddToFavorite(_:)))
        setupConstraints()
        setupTableView()
        viewModel.viewDidLoad()
        setupUI()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.largeTitleTextAttributes?[.foregroundColor] = UIColor.black
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailView.roundCorners(corners: [.topLeft, .topRight], radius: 30)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        viewModel.isBright ? .default : .lightContent
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BaseDetailCell.self)
        tableView.register(StatisticCell.self)
    }
    
    private func setupUI() {
        detailView.backgroundColor = .white
        let image = viewModel.imagePokemon
        pokemonImage.image = image
        view.backgroundColor = image?.averageColor
        let colorText: UIColor = viewModel.isBright ? .black : .white
        navigationController?.navigationBar.largeTitleTextAttributes?[.foregroundColor] = colorText
        navigationController?.navigationBar.tintColor = colorText
        originalFavTintColor = colorText
        navigationItem.rightBarButtonItem?.tintColor = viewModel.isFavoritePokemon ? .yellow : originalFavTintColor
    }
    
    private func setupConstraints() {
        self.view.addSubview(placeholderView)
        self.view.addSubview(detailView)
        NSLayoutConstraint.activate([
            placeholderView.heightAnchor.constraint(equalToConstant: 0),
            placeholderView.bottomAnchor.constraint(equalTo: self.detailView.topAnchor),
            placeholderView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            placeholderView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            detailView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6),
            detailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
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
    
    @objc private func handleAddToFavorite(_ sender: UIBarButtonItem) {
        viewModel.handleFavoriteAction { [weak self] event in
            self?.navigationItem.rightBarButtonItem?.tintColor = event == .added ? .yellow : self?.originalFavTintColor
        }
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
            let cell = tableView.dequeueReusableCell(for: indexPath) as StatisticCell
            cell.configure(with: statisticItem)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableViewHeaderCell = TableViewHeaderCell(text: viewModel.title(for: section))
        tableViewHeaderCell.backgroundColor = .white
        return tableViewHeaderCell
    }
}
