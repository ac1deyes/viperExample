//
//  PokemonRemoteDataSource.swift
//  viperExample
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

class PokemonRemoteDataSource: RemoteDataSource {
    
    func fetchList(offset: Int, limit: Int, completionHandler: @escaping ([PokemonShort]?, Int, Error?) -> ()) {
        PokemonAPI.shared.fetchPokemons(sender: self, offset: offset, limit: limit) { (self, pokemons, maxCount, error) in
            completionHandler(pokemons, maxCount, error)
        }
    }
    
    func cancelFetchList(offset: Int, limit: Int) {
        PokemonAPI.shared.cancelFetchPokemonList(offset: offset, limit: limit)
    }
    
    func fetch(id: Int, completionHandler: @escaping (Pokemon?, Error?) -> ()) {
        PokemonAPI.shared.fetchPokemon(sender: self, id: id) { (self, pokemon, error) in
            completionHandler(pokemon, error)
        }
    }
    
    func cancel(id: Int) {
        PokemonAPI.shared.cancelFetchPokemon(id)
    }
}
