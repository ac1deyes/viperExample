//
//  PokemonDetailInteractor.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

class PokemonDetailInteractor: PresenterToInteractorPokemonDetailProtocol {
    
    weak var presenter: InteractorToPresenterPokemonDetailProtocol?
    var pokemonsRepository: PokemonsRepository
    var pokemon: PokemonShort
    
    init(repository: PokemonsRepository, pokemon: PokemonShort) {
        self.pokemonsRepository = repository
        self.pokemon = pokemon
    }
    
    func loadPokemon() {
        pokemonsRepository.fetchPokemon(id: pokemon.id) { [weak self] pokemon, error in
            if let error = error {
                self?.presenter?.fetchPokemonFailure(error: error)
                return
            }
            self?.presenter?.fetchPokemonSuccess(pokemon: pokemon!)
        }
    }
    
    func cancelRequest() {
        pokemonsRepository.cancel(id: pokemon.id)
    }
}
