//
//  PokemonDataController.swift
//  PokedexTV
//
//  Created by Dan Isacson on 13/03/16.
//  Copyright © 2016 dna. All rights reserved.
//

import Foundation
import SwiftyJSON

class PokemonDataController {
    
    static let sharedInstance = PokemonDataController()
    var pokemonDataDictionary: [Int: JSON]
    
    init() {
        self.pokemonDataDictionary = [:]
    }
    
}