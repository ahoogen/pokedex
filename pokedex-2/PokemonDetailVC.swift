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
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvImg: UIImageView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let img = UIImage(named: "\(pokemon.pokedexId)")
        pokeImg.image = img
        currentEvoImg.image = img
        pokemon.downloadPokemonDetails { () -> () in
            self.updateUi()
        }
        
    }
    
    func updateUi()
    {
        nameLbl.text = pokemon.name.capitalizedString
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        descLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        baseAttackLbl.text = pokemon.attack
        if pokemon.nextEvolutionId != "" {
            let nextId = pokemon.nextEvolutionId
            let nextEvo = pokemon.nextEvolutionTxt
            let nextLevel = pokemon.nextEvolutionLevel
            var str: String = ""
            str = "Next Evolution: \(nextEvo)"
            if nextLevel != "" {
                str += " LVL \(nextLevel)"
            }
            nextEvImg.image = UIImage(named: "\(nextId)")!
        } else {
            nextEvImg.hidden = true
            nextEvolutionLbl.text = "No Evolutions"
        }
    }
    
    @IBAction func backBtnPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
