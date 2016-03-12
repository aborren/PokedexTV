//
//  ViewController.swift
//  PokedexTV
//
//  Created by Dan Isacson on 12/03/16.
//  Copyright © 2016 dna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kTotalAmountOfPokemon
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pokemonCell", forIndexPath: indexPath) as! PokemonCollectionViewCell
        cell.setup(indexPath.row + 1)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewControllerWithIdentifier("PokemonPageViewController") as? PokemonPageViewController {
            vc.pokemonIndex = indexPath.row + 1
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
}