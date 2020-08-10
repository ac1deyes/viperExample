//
//  MockPokemonDetailPresenter.swift
//  viperExampleTests
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
@testable import viperExample

class MockPokemonDetailPresenter: InteractorToPresenterPokemonDetailProtocol, ViewToPresenterPokemonDetailProtocol {
    
    var view: PresenterToViewPokemonDetailProtocol?
    var interactor: PresenterToInteractorPokemonDetailProtocol?
    var router: PresenterToRouterPokemonDetailProtocol?
    
    var pokemonName: String? { return interactor?.pokemon.name }
    
    var pokemon: Pokemon?
    var isSuccess: Bool = false
    var error: Error?
    
    var isViewDidLoad: Bool = false
    var isViewDidDisappear: Bool = false
    
    func fetchPokemonSuccess(pokemon: Pokemon) {
        self.pokemon = pokemon
        isSuccess = true
        view?.onFetchPokemonSuccess()
        view?.hideActivityIndicator()
    }
    
    func fetchPokemonFailure(error: Error) {
        isSuccess = false
        self.error = error
        view?.onFetchPokemonFailure(error: error.localizedDescription)
        view?.hideActivityIndicator()
    }
    
    func viewDidLoad() {
        isViewDidLoad = true
        interactor?.loadPokemon()
        view?.showActivityIndicator()
        view?.pokemonName(interactor?.pokemon.name)
    }
    
    func viewDidDisappear() {
        isViewDidDisappear = true
    }
    
    func numberOfRowsInSection() -> Int {
         guard let _ = pokemon else { return 0 }
         return PokemonDetailPresenter.PokemonRows.allCases.count
    }
    
    func textLabelText(indexPath: IndexPath) -> String? {
        return PokemonDetailPresenter.PokemonRows.allCases[indexPath.row].rawValue
    }
    
    func detailTextLabelText(indexPath: IndexPath) -> String? {
        let row = PokemonDetailPresenter.PokemonRows.allCases[indexPath.row]
        switch row {
        case .baseExperience: return pokemon?.baseExperience.toString
        case .weight: return pokemon?.weight.toString
        case .height: return pokemon?.height.toString
        }
    }
}
