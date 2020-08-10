//
//  PokemonsDataRepository.swift
//  viperExample
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

class PokemonsDataRepository<Remote: RemoteDataSource, Local: LocalDataSource>: PokemonsRepository
where Remote.T == PokemonShort, Remote.I == Pokemon, Local.T == Pokemon {
    private enum LoadingType {
        case new, update
    }
    
    @Injected var remoteDataSource: Remote
    @Injected var localDataSource: Local
    
    func fetchPokemonsList(offset: Int, limit: Int, completionHandler: @escaping ([PokemonShort]?, Int, Error?) -> ()) {
        self.remoteDataSource.fetchList(offset: offset, limit: limit, completionHandler: completionHandler)
    }
    
    func cancelFetchPokemonList(offset: Int ,limit: Int) {
        self.remoteDataSource.cancelFetchList(offset: offset, limit: limit)
    }
    
    func fetchPokemon(id: Int, completionHandler: @escaping (Pokemon?, Error?) -> ()) {
        self.localDataSource.get(id: id) { pokemon, error in
            guard let pokemon = pokemon else {
                self.getRemotePokemon(id: id, loadingType: .new, completionHandler: completionHandler)
                return
            }
            completionHandler(pokemon, error)
            self.getRemotePokemon(id: id, loadingType: .update, completionHandler: completionHandler)
        }
    }
    
    func createPokemon(pokemon: Pokemon?) {
        guard let pokemon = pokemon else { return }
        self.localDataSource.create(pokemon: pokemon)
    }
    
    func cancel(id: Int) {
        self.remoteDataSource.cancel(id: id)
    }
    
    private func getRemotePokemon(id: Int, loadingType: PokemonsDataRepository.LoadingType, completionHandler: @escaping (Pokemon?, Error?) -> ()) {
        self.remoteDataSource.fetch(id: id, completionHandler: { [weak self] pokemon, error in
            self?.createPokemon(pokemon: pokemon)
            completionHandler(pokemon, loadingType == .update ? nil : error)
        })
    }
}




