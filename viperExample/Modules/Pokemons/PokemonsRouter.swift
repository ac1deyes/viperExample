//
//  PokemonsRouter.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import UIKit


class PokemonsRouter: PresenterToRouterPokemonsProtocol {
    
    // MARK: Static methods
    
    static func createModule() -> UINavigationController {
        let viewController = UIStoryboard.pokemonsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterPokemonsProtocol & InteractorToPresenterPokemonsProtocol = PokemonsPresenter()
        let repository = PokemonsDataRepository<PokemonRemoteDataSource, PokemonLocalDataSource>()
        
        viewController.presenter = presenter
        viewController.presenter?.router = PokemonsRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PokemonsInteractor(repository: repository)
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    // MARK: - Navigation
    
    func pushToPokemonDetail(on view: PresenterToViewPokemonsProtocol, with pokemon: PokemonShort, animated: Bool = true) {
        let pokemonDetailViewController = PokemonDetailRouter.createModule(with: pokemon)
        
        let viewController = view as! PokemonsViewController
        viewController.navigationController?.pushViewController(pokemonDetailViewController, animated: animated)
    }
    
    func showError(_ error: Error, on view: PresenterToViewPokemonsProtocol) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        let viewController = view as! PokemonsViewController
        viewController.present(alert, animated: true, completion: nil)
    }
}
