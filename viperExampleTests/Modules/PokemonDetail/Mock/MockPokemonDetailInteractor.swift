//
//  MockPokemonDetailInteractor.swift
//  viperExampleTests
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
@testable import viperExample

class MockPokemonDetailInteractor: PresenterToInteractorPokemonDetailProtocol {
    
    var presenter: InteractorToPresenterPokemonDetailProtocol?
    
    var pokemon: PokemonShort
    
    var loading: Bool = false
    var shouldFail: Bool = false
    
    init(pokemon: PokemonShort) {
        self.pokemon = pokemon
    }
    
    func loadPokemon() {
        loading = true
        
        if shouldFail {
            presenter?.fetchPokemonFailure(error: MockError.pokemonNotExist)
        } else {
            let pokemon = Pokemon(id: 1, name: "pokemon_1", baseExperience: 100, weight: 15, height: 10)
            presenter?.fetchPokemonSuccess(pokemon: pokemon)
        }
    }
    
    func cancelRequest() {
        loading = false
    }
}
