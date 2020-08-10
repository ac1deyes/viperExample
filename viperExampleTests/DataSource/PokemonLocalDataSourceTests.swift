//
//  PokemonLocalDataSourceTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 29.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample

class PokemonLocalDataSourceTests: XCTestCase {

    var sut: PokemonLocalDataSource?
    var repository: PokemonsDataRepository<MockPokemonRemoteDataSource, MockPokemonLocalDataSource>?
    
    override func setUp() {
        sut = PokemonLocalDataSource()
        repository = PokemonsDataRepository()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchPokemonThenProcess() {
        let expectation = self.expectation(description: "Fetch")
        var pokemon: Pokemon?
        
        repository?.fetchPokemon(id: 10, completionHandler: { (_, _) in
            self.sut?.get(id: 10, completionHandler: { (pokemonFromStorage, error) in
                if pokemon == nil {
                    pokemon = pokemonFromStorage
                    expectation.fulfill()
                }
            })
        })
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(pokemon)
    }
    
    func testWhenStorePokemonThenExistInStorage() {
        let id = 13
        let pokemonCreation = Pokemon(id: id, name: "pokemon_13", baseExperience: 100, weight: 200, height: 300)
        
        sut?.create(pokemon: pokemonCreation)
        
        let expectationFetch = self.expectation(description: "Fetch")
        var pokemon: Pokemon?
        
        self.sut?.get(id: id, completionHandler: { (pokemonFromStorage, error) in
            if pokemon == nil {
                pokemon = pokemonFromStorage
                expectationFetch.fulfill()
            }
        })
        
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(pokemon)
        XCTAssertEqual(pokemon?.name, pokemonCreation.name)
    }
}
