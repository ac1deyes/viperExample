//
//  MockPokemonRemoteDataSource.swift
//  viperExampleTests
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
@testable import viperExample

class MockPokemonRemoteDataSource: RemoteDataSource {
    
    let shortPokemons: [PokemonShort] = (1...200).map { PokemonShort(name: "pokemon_\($0)", url: "https:/test.de/\($0)/")}
    let pokemons = [Pokemon(id: 10, name: "pokemon_10", baseExperience: 100, weight: 15, height: 10),
                    Pokemon(id: 1, name: "pokemon_not_1", baseExperience: 110, weight: 25, height: 30)]
    
    var shouldFail: Bool = false
    var isCancelFetching: Bool = false
    
    func fetch(id: Int, completionHandler: @escaping (Pokemon?, Error?) -> ()) {
        let pokemon = pokemons.first { $0.id == id }
        var error: MockError?
        if pokemon == nil {
            error = .pokemonNotExist
        }
        completionHandler(pokemon, error)
    }
    
    func fetchList(offset: Int, limit: Int, completionHandler: @escaping ([PokemonShort]?, Int, Error?) -> ()) {
        if shouldFail {
            completionHandler(nil, 0, MockError.someError)
        } else {
            completionHandler(Array(shortPokemons[offset..<limit+offset]), shortPokemons.count, nil)
        }
    }
    
    func cancelFetchList(offset: Int, limit: Int) {
        isCancelFetching = true
    }
    
    func cancel(id: Int) {

    }
}
