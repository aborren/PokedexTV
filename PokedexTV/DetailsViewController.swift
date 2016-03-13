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
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
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
        
        if !self.isCached(index) {
            self.activityIndicatorView.startAnimating()
            Manager.sharedInstance.request(.GET, "http://pokeapi.co/api/v2/pokemon/\(index)/")
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .Success(let data):
                        let json = JSON(data)
                        PokemonDataController.sharedInstance.pokemonDataDictionary[index] = json
                        self.completionHandler(json)
                    case .Failure(let error):
                        debugPrint(error)
                    }
                    self.activityIndicatorView.stopAnimating()
            }
        }
        
    }
    
    func completionHandler(json: JSON) {
        self.titleLabel.text = json["name"].string?.capitalizedString
        self.setupTypes(json["types"])
        self.setupBodyStats(json)
    }
    
    func isCached(index: Int) -> Bool {
        if let json = PokemonDataController.sharedInstance.pokemonDataDictionary[index] {
            self.completionHandler(json)
            return true
        } else {
            return false
        }
    }
    
    func setupTypes(json: JSON) {
        if let type1 = json[1]["type"]["name"].string {
            self.type1Label.hidden = false
            self.type1Label.layer.cornerRadius = 10
            self.type1Label.text = type1.capitalizedString
            self.type1Label.backgroundColor = Utilities.darkColorForType(type1)
        }
        
        if let type2 = json[0]["type"]["name"].string {
            self.type2Label.hidden = false
            self.type2Label.layer.cornerRadius = 10
            self.type2Label.text = type2.capitalizedString
            self.type2Label.backgroundColor = Utilities.darkColorForType(type2)
        }
    }
    
    func setupBodyStats(json: JSON) {
        if let heightInt = json["height"].int {
            var height = Double(heightInt)
            height /= 10
            self.heightLabel.text = "\(height) m"
        }
        
        if let weightInt = json["weight"].int {
            var weight = Double(weightInt)
            weight /= 10
            self.weightLabel.text = "\(weight) kg"
        }
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
