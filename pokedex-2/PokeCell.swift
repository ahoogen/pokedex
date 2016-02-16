//
//  PokeCell.swift
//  pokedex
//
//  Created by Austen Hoogen on 2/15/16.
//  Copyright © 2016 Austen Hoogen. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbInmg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbInmg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
