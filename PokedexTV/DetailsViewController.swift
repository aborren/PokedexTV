//
//  DetailsViewController.swift
//  PokedexTV
//
//  Created by Dan Isacson on 12/03/16.
//  Copyright © 2016 dna. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailsViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var previousPokemonImageView: UIImageView!
    @IBOutlet weak var nextPokemonImageView: UIImageView!
    
    var pokemonIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupImageViews()
        self.getPokemonInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getPokemonInfo() {
        guard var index = pokemonIndex else {
            return
        }
        
        index = Utilities.formattedPokemonIndex(index)
        self.activityIndicatorView.startAnimating()
        request(.GET, "http://pokeapi.co/api/v2/pokemon/\(index)/")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    self.completionHandler(json)
                case .Failure(let error):
                    debugPrint(error)
                }
                self.activityIndicatorView.stopAnimating()
        }
    }
    
    func completionHandler(json: JSON) {
        self.titleLabel.text = json["name"].string?.capitalizedString
    }
    
    func setupImageViews() {
        guard var index = pokemonIndex else {
            return
        }
        
        index = Utilities.formattedPokemonIndex(index)
        let previousIndex =  Utilities.formattedPokemonIndex(index - 1)
        let nextIndex =  Utilities.formattedPokemonIndex(index + 1)
        
        self.imageView.sd_setImageWithURL(NSURL(string: "http://pokeapi.co/media/sprites/pokemon/\(index).png")!)
        self.previousPokemonImageView.sd_setImageWithURL(NSURL(string: "http://pokeapi.co/media/sprites/pokemon/\(previousIndex).png")!)
        self.nextPokemonImageView.sd_setImageWithURL(NSURL(string: "http://pokeapi.co/media/sprites/pokemon/\(nextIndex).png")!)
    }
}
