//
//  PokemonPageViewController.swift
//  PokedexTV
//
//  Created by Dan Isacson on 12/03/16.
//  Copyright © 2016 dna. All rights reserved.
//

import UIKit
import AVFoundation

class PokemonPageViewController: UIPageViewController {

    var pokemonIndex = 1
    var nextPokemonIndex = 1
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        self.view.backgroundColor = UIColor.clearColor()
        setViewControllers([self.getDetailsViewControllerWithIndex(pokemonIndex)], direction: .Forward, animated: true, completion: nil)
        
        let playPauseRecognizer = UITapGestureRecognizer(target: self, action: "playPauseRecognizer")
        playPauseRecognizer.allowedPressTypes = [NSNumber(integer:UIPressType.PlayPause.rawValue)]
        
        self.view.addGestureRecognizer(playPauseRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDetailsViewControllerWithIndex(index: Int) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewControllerWithIdentifier("DetailsViewController") as? DetailsViewController {
            
            vc.pokemonIndex = index
            
            return vc
        }
        
        return UIViewController()
    }
    
    func playPauseRecognizer() {
        let index = Utilities.formattedPokemonIndex(pokemonIndex)
        
        if let url = NSBundle.mainBundle().URLForResource("\(index)", withExtension: "wav") {
            do { player = try AVAudioPlayer(contentsOfURL: url, fileTypeHint: nil) }
            catch let error as NSError { print(error.description) }
            
            player.numberOfLoops = 0
            player.prepareToPlay()
            player.play()
        }
    }
    
}

extension PokemonPageViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return self.getDetailsViewControllerWithIndex(self.pokemonIndex + 1)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return self.getDetailsViewControllerWithIndex(self.pokemonIndex - 1)
    }
}

extension PokemonPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        if let vc = pendingViewControllers.first as? DetailsViewController {
            if let nextIndex = vc.pokemonIndex {
                self.nextPokemonIndex = nextIndex
            }
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            self.pokemonIndex = self.nextPokemonIndex
        }
    }
}
