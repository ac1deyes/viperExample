//
//  PokemonRemoteDataSourceTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 29.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample

class PokemonRemoteDataSourceTests: XCTestCase {

    var sut: PokemonRemoteDataSource?
    
    override func setUp() {
        sut = PokemonRemoteDataSource()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testWhenFetchPokemonThenRecieveData() throws {
        let id = 777
        let expectation = self.expectation(description: "Fetch")
        var pokemon: Pokemon?
        
        sut?.fetch(id: id, completionHandler: { (pokemonRemote, error) in
            pokemon = pokemonRemote
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertNotNil(pokemon)
    }
    
    func testCancelFetchPokemonListThenNoCrash() {
        sut?.cancelFetchList(offset: 0, limit: 0)
    }
    
    func testCancelFetchPokemonThenNoCrash() {
        sut?.cancel(id: 0)
    }
}
