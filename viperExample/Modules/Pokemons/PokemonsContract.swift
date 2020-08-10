//
//  PokemonsContract.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewPokemonsProtocol: class {
    func onFetchPokemonsSuccess()
    func onFetchPokemonsFailure(error: String)
    
    func showActivityIndicator()
    func hideActivityIndicator()
    
    func showFooterView()
    func hideFooterView()
    
    func endRefreshing()
    
    func disableRefresh()
    func enableRefresh()
    
    func deselectRowAt(row: Int)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterPokemonsProtocol: class {
    
    var view: PresenterToViewPokemonsProtocol? { get set }
    var interactor: PresenterToInteractorPokemonsProtocol? { get set }
    var router: PresenterToRouterPokemonsProtocol? { get set }
    
    var pokemonsNames: [String] { get set }
    
    func viewDidLoad()
    
    func refresh()
    
    func numberOfRowsInSection() -> Int
    func textLabelText(indexPath: IndexPath) -> String?
    
    func didSelectRowAt(index: Int)
    func willDisplayRowAt(index: Int)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorPokemonsProtocol: class {
    
    var presenter: InteractorToPresenterPokemonsProtocol? { get set }
    
    func loadPokemons(_ loadingType: LoadingType)
    func retrievePokemon(at index: Int)
    func cancelFetchPokemonList()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterPokemonsProtocol: class {
    
    func fetchPokemonsSuccess(pokemons: [PokemonShort], maxCount: Int, loadingType: LoadingType)
    func fetchPokemonsFailure(error: Error, loadingType: LoadingType)
    
    func getPokemonSuccess(_ pokemon: PokemonShort)
    func getPokemonFailure()
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterPokemonsProtocol: class {
    
    static func createModule() -> UINavigationController
    
    func showError(_ error: Error, on view: PresenterToViewPokemonsProtocol)
    func pushToPokemonDetail(on view: PresenterToViewPokemonsProtocol, with pokemon: PokemonShort, animated: Bool)
}
