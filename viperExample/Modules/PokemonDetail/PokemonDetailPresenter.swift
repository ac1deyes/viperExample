//
//  PokemonDetailPresenter.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

class PokemonDetailPresenter: ViewToPresenterPokemonDetailProtocol {
    
    enum PokemonRows: String, CaseIterable {
        case baseExperience = "Base Experience"
        case weight = "Weight"
        case height = "Height"
    }
    
    weak var view: PresenterToViewPokemonDetailProtocol?
    var interactor: PresenterToInteractorPokemonDetailProtocol?
    var router: PresenterToRouterPokemonDetailProtocol?
    
    var pokemon: Pokemon?
    
    func viewDidLoad() {
        interactor?.loadPokemon()
        view?.showActivityIndicator()
        view?.pokemonName(interactor?.pokemon.name)
    }
    
    func viewDidDisappear() {
        interactor?.cancelRequest()
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

// MARK: - InteractorToPresenterPokemonDetailProtocol

extension PokemonDetailPresenter: InteractorToPresenterPokemonDetailProtocol {
    
    func fetchPokemonSuccess(pokemon: Pokemon) {
        self.pokemon = pokemon
        view?.onFetchPokemonSuccess()
        view?.hideActivityIndicator()
    }
    
    func fetchPokemonFailure(error: Error) {
        view?.onFetchPokemonFailure(error: error.localizedDescription)
        view?.hideActivityIndicator()
    }
}
