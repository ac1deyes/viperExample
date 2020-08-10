//
//  PokemonsRepository.swift
//  viperExample
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

protocol PokemonsRepository {
    func fetchPokemonsList(offset: Int, limit: Int, completionHandler: @escaping ([PokemonShort]?, Int, Error?) -> ())
    func cancelFetchPokemonList(offset: Int ,limit: Int)
    
    func fetchPokemon(id: Int, completionHandler: @escaping (Pokemon?, Error?) -> ())
    func createPokemon(pokemon: Pokemon?)
    func cancel(id: Int)
}
