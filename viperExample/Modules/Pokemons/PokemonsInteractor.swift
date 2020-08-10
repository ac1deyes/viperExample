//
//  PokemonsInteractor.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

class PokemonsInteractor: PresenterToInteractorPokemonsProtocol {
    
    weak var presenter: InteractorToPresenterPokemonsProtocol?
    var pokemonsRepository: PokemonsRepository
    var pokemons: [PokemonShort] = []
    
    private var offset: Int { return pokemons.count }
    private let limit: Int = 50
    
    init(repository: PokemonsRepository) {
        self.pokemonsRepository = repository
    }
    
    func loadPokemons(_ loadingType: LoadingType) {
        pokemonsRepository.fetchPokemonsList(offset: offset, limit: limit) { [weak self] (pokemons, maxCount, error) in
            if let error = error {
                self?.presenter?.fetchPokemonsFailure(error: error, loadingType: loadingType)
                return
            }
            
            switch loadingType {
            case .load, .refresh: self?.pokemons = pokemons!
            case .loadNext: self?.pokemons.append(contentsOf: pokemons!)
            }
            
            self?.presenter?.fetchPokemonsSuccess(pokemons: pokemons!, maxCount: maxCount, loadingType: loadingType)
        }
    }
    
    func retrievePokemon(at index: Int) {
        guard pokemons.indices.contains(index) else {
            self.presenter?.getPokemonFailure()
            return
        }
        self.presenter?.getPokemonSuccess(self.pokemons[index])
    }
    
    func cancelFetchPokemonList() {
        pokemonsRepository.cancelFetchPokemonList(offset: offset, limit: limit)
    }
    
}
