//
//  MockPokemonsPresenter.swift
//  viperExampleTests
//
//  Created by Vladislav on 28.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
@testable import viperExample

class MockPokemonsPresenter: ViewToPresenterPokemonsProtocol {
    
    var view: PresenterToViewPokemonsProtocol?
    var interactor: PresenterToInteractorPokemonsProtocol?
    var router: PresenterToRouterPokemonsProtocol?
    
    var pokemonsNames: [String] = []
    
    var isFetchSuccess: Bool = false
    var isRetrieveSuccess: Bool = false
    
    var isViewDidLoad: Bool = false
    var isRefreshing: Bool = false
    var didSelectRowIndex: Int?
    var willDisplayRowIndex: Int?
    
    func viewDidLoad() {
        isViewDidLoad = true
    }
    
    func refresh() {
        isRefreshing = true
    }
    
    func numberOfRowsInSection() -> Int {
        return pokemonsNames.count
    }
    
    func textLabelText(indexPath: IndexPath) -> String? {
        return pokemonsNames[indexPath.row]
    }
    
    func didSelectRowAt(index: Int) {
        didSelectRowIndex = index
    }
    
    func willDisplayRowAt(index: Int) {
        willDisplayRowIndex = index
        if index >= 47 {
            view?.showFooterView()
            interactor?.loadPokemons(.loadNext)
        }
    }
}


extension MockPokemonsPresenter: InteractorToPresenterPokemonsProtocol {
    
    func fetchPokemonsSuccess(pokemons: [PokemonShort], maxCount: Int, loadingType: LoadingType) {
        isFetchSuccess = true
        
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
        
        view?.onFetchPokemonsSuccess()
    }
    
    func fetchPokemonsFailure(error: Error, loadingType: LoadingType) {
        isFetchSuccess = false
        switch loadingType {
        case .load:
            view?.hideActivityIndicator()
            view?.enableRefresh()
        case .loadNext:
            view?.hideFooterView()
        case .refresh:
            view?.endRefreshing()
        }
        
        view?.onFetchPokemonsFailure(error: error.localizedDescription)
    }
    
    func getPokemonSuccess(_ pokemon: PokemonShort) {
        isRetrieveSuccess = true
    }
    
    func getPokemonFailure() {
        isRetrieveSuccess = false
    }
}
