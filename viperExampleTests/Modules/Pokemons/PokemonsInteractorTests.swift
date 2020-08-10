//
//  PokemonsInteractorTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 28.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample
import Resolver

class PokemonsInteractorTests: XCTestCase {
    
    var sut: PokemonsInteractor!
    var mockPresenter: MockPokemonsPresenter!
    
    var remoteDataSource: MockPokemonRemoteDataSource!
    
    override func setUp() {
        let repository = PokemonsDataRepository<MockPokemonRemoteDataSource, MockPokemonLocalDataSource>()
        remoteDataSource = repository.remoteDataSource
        
        sut = PokemonsInteractor(repository: repository)
        mockPresenter = MockPokemonsPresenter()
        sut.presenter = mockPresenter
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func testWhenFetchPokemonsSuccessThenProcess() {
        remoteDataSource.shouldFail = false
        sut.loadPokemons(.load)
        XCTAssertTrue(mockPresenter.isFetchSuccess)
    }
    
    func testWhenFetchPokemonsFailureThenProcess() {
        remoteDataSource.shouldFail = true
        sut.loadPokemons(.load)
        XCTAssertFalse(mockPresenter.isFetchSuccess)
    }
    
    func testWhenRetrievePokemonSuccessThenProcess() {
        remoteDataSource.shouldFail = false
        sut.loadPokemons(.load)
        sut.retrievePokemon(at: 0)
        XCTAssertTrue(mockPresenter.isRetrieveSuccess)
    }
    
    func testWhenRetrievePokemonFailureThenProcess() {
        remoteDataSource.shouldFail = false
        sut.loadPokemons(.load)
        sut.retrievePokemon(at: 50)
        XCTAssertFalse(mockPresenter.isRetrieveSuccess)
    }
    
    func testWhenPaginationThenRetievePokemonSuccess() {
        remoteDataSource.shouldFail = false
        sut.loadPokemons(.load)
        sut.loadPokemons(.loadNext)
        sut.retrievePokemon(at: 51)
        XCTAssertTrue(mockPresenter.isRetrieveSuccess)
    }
    
    func testWhenCancelFetchThenProcess() {
        sut.cancelFetchPokemonList()
        XCTAssertTrue(remoteDataSource.isCancelFetching)
    }
}
