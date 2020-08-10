//
//  MockPokemonsInteractor.swift
//  viperExampleTests
//
//  Created by Vladislav on 28.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
@testable import viperExample

class MockPokemonsInteractor: PresenterToInteractorPokemonsProtocol {
    
    var presenter: InteractorToPresenterPokemonsProtocol?
    
    var currentPokemons: [PokemonShort] = []
    
    var shouldFail: Bool = false
    var shouldSimulateResponseAwaiting: Bool = false
    
    var isLoading: Bool = false
    var isLoadingNext: Bool = false
    var isRequestsCanceled: Bool = false
    var isRetrieving: Bool = false
    
    private var offset: Int = 0
    private let limit = 50
    private let networkPokemons = (1...200).map { PokemonShort(name: "pokemon_\($0)", url: "https:/test.de/\($0)/")}
    
    
    func loadPokemons(_ loadingType: LoadingType) {
        guard !shouldSimulateResponseAwaiting else { return }
        
        switch loadingType {
        case .load:
            isLoading = true
        case .loadNext:
            isLoadingNext = true
        default: break
        }
        
        if shouldFail {
            presenter?.fetchPokemonsFailure(error: MockError.someError, loadingType: loadingType)
        } else {
            
            let pokemons = Array(networkPokemons[offset..<limit+offset])
            
            switch loadingType {
            case .load, .refresh: self.currentPokemons = pokemons
            case .loadNext: self.currentPokemons.append(contentsOf: pokemons)
            }
            
            presenter?.fetchPokemonsSuccess(pokemons: currentPokemons, maxCount: networkPokemons.count, loadingType: loadingType)
            offset += 50
        }
    }
    
    func retrievePokemon(at index: Int) {
        isRetrieving = true
        let pokemons = Array(networkPokemons[offset..<limit+offset])
        guard pokemons.indices.contains(index) else {
            self.presenter?.getPokemonFailure()
            return
        }
        self.presenter?.getPokemonSuccess(self.networkPokemons[index])
    }
    

    func cancelFetchPokemonList() {
        isRequestsCanceled = true
    }
    
}
