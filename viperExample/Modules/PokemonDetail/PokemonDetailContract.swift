//
//  PokemonDetailContract.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewPokemonDetailProtocol: class {
    func onFetchPokemonSuccess()
    func onFetchPokemonFailure(error: String)
    
    func showActivityIndicator()
    func hideActivityIndicator()
    
    func pokemonName(_ name: String?)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterPokemonDetailProtocol: class {
    var view: PresenterToViewPokemonDetailProtocol? { get set }
    var interactor: PresenterToInteractorPokemonDetailProtocol? { get set }
    var router: PresenterToRouterPokemonDetailProtocol? { get set }
    
    var pokemon: Pokemon? { get set }
    
    func viewDidLoad()
    func viewDidDisappear()
    
    func numberOfRowsInSection() -> Int
    func textLabelText(indexPath: IndexPath) -> String?
    func detailTextLabelText(indexPath: IndexPath) -> String?
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorPokemonDetailProtocol: class {
    
    var presenter: InteractorToPresenterPokemonDetailProtocol? { get set }
    var pokemon: PokemonShort { get set }
    
    func loadPokemon()
    func cancelRequest()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterPokemonDetailProtocol: class {
    var pokemon: Pokemon? { get set }
    
    func fetchPokemonSuccess(pokemon: Pokemon)
    func fetchPokemonFailure(error: Error)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterPokemonDetailProtocol: class {
    
    static func createModule(with pokemon: PokemonShort) -> UIViewController
}
