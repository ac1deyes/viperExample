//
//  PokemonsPresenter.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

class PokemonsPresenter: ViewToPresenterPokemonsProtocol {
    
    weak var view: PresenterToViewPokemonsProtocol?
    var interactor: PresenterToInteractorPokemonsProtocol?
    var router: PresenterToRouterPokemonsProtocol?
    
    var pokemonsNames: [String] = []
    private var pokemonsLeftBeforeLoadNext: Int = 3
    private var maxCount: Int = 0
    
    private var loadingStatus: LoadingStatus = .none
    
    func viewDidLoad() {
        view?.showActivityIndicator()
        view?.disableRefresh()
        loadingStatus = .loading(.load)
        interactor?.loadPokemons(.load)
    }
    
    func refresh() {
        if loadingStatus == .loading(.loadNext) {
            interactor?.cancelFetchPokemonList()
            view?.hideFooterView()
        }
        loadingStatus = .loading(.refresh)
        interactor?.loadPokemons(.refresh)
    }
    
    func numberOfRowsInSection() -> Int {
        return pokemonsNames.count
    }
    
    func textLabelText(indexPath: IndexPath) -> String? {
        return pokemonsNames[safe: indexPath.row]
    }
    
    func didSelectRowAt(index: Int) {
        interactor?.retrievePokemon(at: index)
        view?.deselectRowAt(row: index)
    }
    
    func willDisplayRowAt(index: Int) {
        if maxCount > pokemonsNames.count,
            pokemonsNames.count - pokemonsLeftBeforeLoadNext <= index,
            loadingStatus == .none {
            
            loadingStatus = .loading(.loadNext)
            view?.showFooterView()
            interactor?.loadPokemons(.loadNext)
        }
    }
    
}

// MARK: - InteractorToPresenterPokemonsProtocol

extension PokemonsPresenter: InteractorToPresenterPokemonsProtocol {
    
    func fetchPokemonsSuccess(pokemons: [PokemonShort], maxCount: Int, loadingType: LoadingType) {
        self.maxCount = maxCount
        
        switch loadingType {
        case .load:
            self.pokemonsNames = pokemons.map { $0.name }
            view?.hideActivityIndicator()
            view?.enableRefresh()
        case .loadNext:
            self.pokemonsNames.append(contentsOf: pokemons.map { $0.name })
            view?.hideFooterView()
        case .refresh:
            self.pokemonsNames = pokemons.map { $0.name }
            view?.endRefreshing()
        }
        loadingStatus = .none
        view?.onFetchPokemonsSuccess()
    }
    
    func fetchPokemonsFailure(error: Error, loadingType: LoadingType) {
        view?.onFetchPokemonsFailure(error: error.localizedDescription)
        
        switch loadingType {
        case .load:
            view?.hideActivityIndicator()
            view?.enableRefresh()
        case .loadNext:
            view?.hideFooterView()
        case .refresh:
            view?.endRefreshing()
        }
        self.loadingStatus = .none
        
        router?.showError(error, on: view!)
    }
    
    func getPokemonSuccess(_ pokemon: PokemonShort) {
        router?.pushToPokemonDetail(on: view!, with: pokemon, animated: true)
    }
    
    func getPokemonFailure() {
        router?.showError(PokemonError.unexpected, on: view!)
    }
}
