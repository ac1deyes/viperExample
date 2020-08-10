//
//  MockPokemonLocalDataSource.swift
//  viperExampleTests
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
@testable import viperExample

class MockPokemonLocalDataSource: LocalDataSource {
    
    var pokemons: [Pokemon] = [Pokemon(id: 1, name: "pokemon_1", baseExperience: 100, weight: 15, height: 10)]
    
    func get(id: Int, completionHandler: @escaping (Pokemon?, Error?) -> ()) {
        completionHandler(pokemons.first { $0.id == id }, nil)
    }
    
    func create(pokemon: Pokemon) {
        if let index = pokemons.firstIndex(where: { $0.id == pokemon.id }) {
            pokemons.remove(at: index)
            pokemons.insert(pokemon, at: index)
            return
        }
        pokemons.append(pokemon)
    }
}
