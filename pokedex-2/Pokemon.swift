//
//  Pokemon.swift
//  pokedex
//
//  Created by Austen Hoogen on 2/15/16.
//  Copyright © 2016 Austen Hoogen. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon
{
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _pokemonUrl: String!
    
    var name: String {
        get {
            return _name
        }
    }
    
    var pokedexId: Int {
        get {
            return _pokedexId
        }
    }
    
    init(name: String, pokedexId: Int)
    {
        _name = name
        _pokedexId = pokedexId
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete)
    {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                self._type = ""
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    var multiples: Bool = false
                    for type in types {
                        if multiples {
                            self._type! += " / "
                        }
                        
                        self._type! += type["name"]!.capitalizedString
                        multiples = true
                    }
                }
                
                self._description = "NODESC"
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] where descriptions.count > 0 {
                    if let uri = descriptions[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(uri)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let dRes = response.result
                            if let descDict = dRes.value as? Dictionary<String, AnyObject> {
                                if let desc = descDict["description"] as? String {
                                    print("From closure: \(desc)")
                                    self._description = desc
                                    print(self._type)
                                    print(self._weight)
                                    print(self._height)
                                    print(self._baseAttack)
                                    print(self._defense)
                                    print(self._description)
                                }
                            }
                            completed()
                        }
                    }
                }
            }
        }
    }
}