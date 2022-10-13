//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Eliano Corallo on 12/10/22.
//

import UIKit

class PokemonListViewController: UIViewController {
    
//    @ProgrammaticallyConstrained private var collectionView: UICollectionView = UICollectionView()
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
//        collectionView.edgeTo(view: self.view)
//        collectionView.backgroundColor = .red
        
//        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(repeatFunc), userInfo: nil, repeats: true)
        repeatFunc()
        
//        PokemonApiManager.shared.getPokemons(url: nil) { _ in
//
//        }
       
    }
    
    @objc func repeatFunc() {
        PokemonApiManager.shared.fetchPokemons { res in
            switch res {
            case .success(let res):
                print(res)
            case .failure(let err):
                print(res)
            }
        }
    }


}

