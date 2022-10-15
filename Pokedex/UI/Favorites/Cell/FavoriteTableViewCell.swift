//
//  FavoriteTableViewCell.swift
//  Pokedex
//
//  Created by Eliano Corallo on 15/10/22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var secondType: UILabel!
    @IBOutlet weak var firstType: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    
}
