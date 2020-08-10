//
//  UIStoryboard+ Extensions.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static func pokemonsViewController() -> PokemonsViewController {
        return storyboardNamed("Main", viewIdentifier: "PokemonsViewController") as! PokemonsViewController
    }
    
    static func pokemonDetailViewController() -> PokemonDetailViewController {
        return storyboardNamed("Main", viewIdentifier: "PokemonDetailViewController") as! PokemonDetailViewController
    }
    
    static private func storyboardNamed(_ name: String, viewIdentifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewIdentifier)
        return viewController
    }
}
