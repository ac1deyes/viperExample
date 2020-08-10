//
//  PokemonsRouterTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 28.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample

class PokemonsRouterTests: XCTestCase {
    
    var sut: PokemonsRouter?
    var viewController: PokemonsViewController?
    
    override func setUp() {
        sut = PokemonsRouter()
        viewController = PokemonsRouter.createModule().viewControllers.first as? PokemonsViewController
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        super.tearDown()
    }
    
    func testModuleSuccessfullyCreates() {
        XCTAssertNotNil(viewController?.presenter)
        XCTAssertNotNil(viewController?.presenter?.router)
        XCTAssertNotNil(viewController?.presenter?.view)
        XCTAssertNotNil(viewController?.presenter?.interactor)
        XCTAssertNotNil(viewController?.presenter?.interactor?.presenter)
    }

    func testPushDetailPokemon() {
        let pokemon = PokemonShort(name: "pokemon_1", url: "http:/test.de/1/")
        sut?.pushToPokemonDetail(on: viewController!, with: pokemon, animated: false)
        XCTAssertTrue(viewController?.navigationController?.visibleViewController is PokemonDetailViewController)
    }
    
    func testShowError() {
        sut?.showError(MockError.pokemonNotExist, on: viewController!)
    }
}
