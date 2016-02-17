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
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
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
    
    var description: String {
        get {
            if _description == nil {
                _description = ""
            }
            return _description
        }
    }
    
    var type: String {
        get {
            if _type == "nil" {
                _type = ""
            }
            return _type
        }
    }
    
    var defense: String {
        get {
            if _defense == nil {
                _defense = ""
            }
            return _defense
        }
    }
    
    var height: String {
        get {
            if _height == nil {
                _height = ""
            }
            return _height
        }
    }
    
    var weight: String {
        get {
            if _weight == nil {
                _weight = ""
            }
            return _weight
        }
    }
    
    var attack: String {
        get {
            if _baseAttack == nil {
                _baseAttack = ""
            }
            return _baseAttack
        }
    }
    
    var nextEvolutionTxt: String {
        get {
            if _nextEvolutionTxt == nil {
                _nextEvolutionTxt = ""
            }
            return _nextEvolutionTxt
        }
    }
    
    var nextEvolutionLevel: String {
        get {
            if _nextEvolutionLevel == nil {
                _nextEvolutionLevel = ""
            }
            return _nextEvolutionLevel
        }
    }
    
    var nextEvolutionId: String {
        get {
            if _nextEvolutionId == nil {
                _nextEvolutionId = ""
            }
            return _nextEvolutionId
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
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    self._type = ""
                    var multiples: Bool = false
                    for type in types {
                        if multiples {
                            self._type! += " / "
                        }
                        
                        self._type! += type["name"]!.capitalizedString
                        multiples = true
                    }
                }
                
                if let evolArr = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolArr.count > 0 {
                    if let to = evolArr[0]["to"] as? String {
                        if to.rangeOfString("mega") == nil {
                            self._nextEvolutionTxt = to
                            if let str = evolArr[0]["resource_uri"] as? String {
                                let newStr = str.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionId = num
                            }
                            if let level = evolArr[0]["level"] as? Int {
                                self._nextEvolutionLevel = "\(level)"
                            }
                        }
                    }
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] where descriptions.count > 0 {
                    if let uri = descriptions[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(uri)")!
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let dRes = response.result
                            if let descDict = dRes.value as? Dictionary<String, AnyObject> {
                                if let desc = descDict["description"] as? String {
                                    self._description = desc
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