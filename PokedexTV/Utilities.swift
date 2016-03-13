//
//  Utilities.swift
//  PokedexTV
//
//  Created by Dan Isacson on 12/03/16.
//  Copyright © 2016 dna. All rights reserved.
//

import Foundation
import UIKit

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
    
    static func darkColorForType(type: String) -> UIColor {
        switch type {
        case "normal":
            return UIColor(red:0.43, green:0.43, blue:0.31, alpha:1.0)
        case "fighting":
            return UIColor(red:0.49, green:0.12, blue:0.10, alpha:1.0)
        case "flying":
            return UIColor(red:0.43, green:0.37, blue:0.61, alpha:1.0)
        case "poison":
            return UIColor(red:0.41, green:0.16, blue:0.41, alpha:1.0)
        case "ground":
            return UIColor(red:0.57, green:0.49, blue:0.27, alpha:1.0)
        case "rock":
            return UIColor(red:0.47, green:0.41, blue:0.14, alpha:1.0)
        case "bug":
            return UIColor(red:0.43, green:0.47, blue:0.08, alpha:1.0)
        case "ghost":
            return UIColor(red:0.29, green:0.22, blue:0.39, alpha:1.0)
        case "steel":
            return UIColor(red:0.47, green:0.47, blue:0.53, alpha:1.0)
        case "fire":
            return UIColor(red:0.61, green:0.33, blue:0.12, alpha:1.0)
        case "water":
            return UIColor(red:0.27, green:0.37, blue:0.61, alpha:1.0)
        case "grass":
            return UIColor(red:0.31, green:0.51, blue:0.20, alpha:1.0)
        case "electric":
            return UIColor(red:0.63, green:0.53, blue:0.12, alpha:1.0)
        case "psychic":
            return UIColor(red:0.63, green:0.22, blue:0.35, alpha:1.0)
        case "ice":
            return UIColor(red:0.39, green:0.55, blue:0.55, alpha:1.0)
        case "dragon":
            return UIColor(red:0.29, green:0.14, blue:0.63, alpha:1.0)
        case "dark":
            return UIColor(red:0.29, green:0.22, blue:0.18, alpha:1.0)
        case "fairy":
            return UIColor(red:0.61, green:0.39, blue:0.44, alpha:1.0)
        default:
            return UIColor.blackColor()
        }
    }
}