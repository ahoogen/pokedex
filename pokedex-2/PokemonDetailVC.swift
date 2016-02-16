//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Austen Hoogen on 2/15/16.
//  Copyright © 2016 Austen Hoogen. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    @IBOutlet weak var nextEvImg1: UIImageView!
    @IBOutlet weak var nextEvImg2: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        
    }
    
    @IBAction func backBtnPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
