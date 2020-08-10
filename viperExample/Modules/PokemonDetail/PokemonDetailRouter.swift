//
//  PokemonDetailRouter.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import UIKit

class PokemonDetailRouter: PresenterToRouterPokemonDetailProtocol {
    
    static func createModule(with pokemon: PokemonShort) -> UIViewController {
        let viewController = UIStoryboard.pokemonDetailViewController()
        
        let presenter: ViewToPresenterPokemonDetailProtocol & InteractorToPresenterPokemonDetailProtocol = PokemonDetailPresenter()
        let repository = PokemonsDataRepository<PokemonRemoteDataSource, PokemonLocalDataSource>()
        
        viewController.presenter = presenter
        viewController.presenter?.router = PokemonDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = PokemonDetailInteractor(repository: repository, pokemon: pokemon)
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    
}
