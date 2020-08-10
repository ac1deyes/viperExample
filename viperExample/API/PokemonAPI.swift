//
//  PokemonsService.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
import Alamofire

class PokemonAPI {
    
    static let shared = PokemonAPI()
    
    private let networdDataFetcher = NetworkDataFetcher()
    
    private init() { }
    
    func fetchPokemons<Object: AnyObject>(sender: Object, offset: Int, limit: Int, completionHandler: ((Object?, [PokemonShort]?, Int, Error?)->())?) {
        networdDataFetcher.request(endpoint: .pokemonList(offset: offset, limit: limit), method: .get) { [weak sender] (response, error)  in
            let pokemonsJSON = response["results"] as? [[String: Any]]
            let pokemons: [PokemonShort] = pokemonsJSON?.decode() ?? []
            let maxCount = response["count"] as? Int ?? pokemons.count
            completionHandler?(sender, pokemons, maxCount, error)
        }
    }
    
    func fetchPokemon<Object: AnyObject>(sender: Object, id: Int, completionHandler: ((Object?, Pokemon?, Error?)->())?) {
        networdDataFetcher.request(endpoint: .pokemon(id), method: .get) { [weak sender] (response, error) in
            do {
                let pokemon: Pokemon = try response.decode()
                completionHandler?(sender, pokemon, error)
            } catch let error {
                completionHandler?(sender, nil, error)
            }
        }
    }
    
    func cancelFetchPokemon(_ id: Int) {
        networdDataFetcher.cancelRequest(.pokemon(id))
    }
    
    func cancelFetchPokemonList(offset: Int ,limit: Int) {
        networdDataFetcher.cancelRequest(.pokemonList(offset: offset, limit: limit))
    }
}
