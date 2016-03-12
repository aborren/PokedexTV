//
//  PokemonCollectionViewCell.swift
//  PokedexTV
//
//  Created by Dan Isacson on 12/03/16.
//  Copyright © 2016 dna. All rights reserved.
//

import UIKit
import SDWebImage

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(index: Int) {
        self.imageView.sd_setImageWithURL(NSURL(string: "http://pokeapi.co/media/sprites/pokemon/\(index).png")!)
    }
}
