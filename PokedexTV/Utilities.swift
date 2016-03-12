//
//  Utilities.swift
//  PokedexTV
//
//  Created by Dan Isacson on 12/03/16.
//  Copyright © 2016 dna. All rights reserved.
//

import Foundation

class Utilities {
    static func formattedPokemonIndex(index: Int) -> Int {
        var formattedPokemonIndex = index % kTotalAmountOfPokemon
        if formattedPokemonIndex == 0 {
            formattedPokemonIndex = kTotalAmountOfPokemon
        }
        
        while formattedPokemonIndex < 0 {
            formattedPokemonIndex += kTotalAmountOfPokemon
        }
        
        return formattedPokemonIndex
    }
}