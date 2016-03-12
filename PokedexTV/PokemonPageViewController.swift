//
//  PokemonPageViewController.swift
//  PokedexTV
//
//  Created by Dan Isacson on 12/03/16.
//  Copyright © 2016 dna. All rights reserved.
//

import UIKit

class PokemonPageViewController: UIPageViewController {

    var pokemonIndex = 1
    var nextPokemonIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        self.view.backgroundColor = UIColor.clearColor()
        setViewControllers([self.getDetailsViewControllerWithIndex(pokemonIndex)], direction: .Forward, animated: true, completion: nil)
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
