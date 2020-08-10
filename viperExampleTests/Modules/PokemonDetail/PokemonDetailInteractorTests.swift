//
//  PokemonDetailInteractorTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample
import Resolver

class PokemonDetailInteractorTests: XCTestCase {
    
    var sut: PokemonDetailInteractor!
    var mockPresenter: MockPokemonDetailPresenter!
    
    var localDataSource: MockPokemonLocalDataSource!
    
    override func setUp() {
        
        Resolver.mock.register{ MockPokemonLocalDataSource() }
        Resolver.mock.register{ MockPokemonRemoteDataSource() }
        
        mockPresenter = MockPokemonDetailPresenter()
        
        let repository = PokemonsDataRepository<MockPokemonRemoteDataSource, MockPokemonLocalDataSource>()
        localDataSource = repository.localDataSource
        
        let pokemon = PokemonShort(name: "pokemon_10", url: "http:/test.de/10/")
        sut = PokemonDetailInteractor(repository: repository, pokemon: pokemon)
        sut.presenter = mockPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        localDataSource = nil
        super.tearDown()
    }
    
    func testWhenPokemonNotStoredInLocalThenRemoteLoadPokemonSuccess() {
        XCTAssertNil(mockPresenter?.pokemon)
        sut.loadPokemon()
        XCTAssertNotNil(mockPresenter?.pokemon)
    }
    
    func testWhenLocalStoreNotContainPokemonThenPokemonCreatesAfterRemoteLoad() {
        sut.pokemon = PokemonShort(name: "pokemon_10", url: "http:/test.de/10/")
        XCTAssertFalse(localDataSource.pokemons.contains { $0.id == 10 })
        sut.loadPokemon()
        XCTAssertTrue(localDataSource.pokemons.contains { $0.id == 10 })
    }
    
    func testWhenRemoteLoadThenPokemonUpdatesInLocalStore() {
        sut.pokemon = PokemonShort(name: "pokemon_1", url: "http:/test.de/1/")
        XCTAssertTrue(localDataSource.pokemons.contains { $0.id == 1 })
        sut.loadPokemon()
        XCTAssertNil(localDataSource.pokemons.first { $0.name == "pokemon_1"})
        XCTAssertNotNil(localDataSource.pokemons.first { $0.name == "pokemon_not_1"})
    }
    
    func testWhenReceiveRemoteErrorThenProcessSuccessfully() {
        sut.pokemon = PokemonShort(name: "pokemon_11", url: "http:/test.de/11/")
        sut.loadPokemon()
        XCTAssertFalse(mockPresenter.isSuccess)
        XCTAssertEqual(mockPresenter.error?.localizedDescription, MockError.pokemonNotExist.localizedDescription)
    }
    
    func testWhenNoPokemonIdThenNoCrash() {
        sut.cancelRequest()
    }
    
    func testWhenCancelRequestNoCrash() {
        sut.pokemon = PokemonShort(name: "pokemon_1", url: "http:/test.de/1/")
        sut.loadPokemon()
        sut.cancelRequest()
    }
}











