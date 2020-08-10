//
//  PokemonDetailRouterTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample

class PokemonDetailRouterTests: XCTestCase {

    var sut: PokemonDetailViewController?
    
    override func setUp() {
        let pokemon = PokemonShort(name: "pokemon_1", url: "http:/test.de/1/")
        sut = PokemonDetailRouter.createModule(with: pokemon) as? PokemonDetailViewController
        super.setUp()
    }
    
    override func tearDown() {
      sut = nil
      super.tearDown()
    }
    
    func testModuleSuccessfullyCreates() {
        XCTAssertNotNil(sut?.presenter)
        XCTAssertNotNil(sut?.presenter?.router)
        XCTAssertNotNil(sut?.presenter?.view)
        XCTAssertNotNil(sut?.presenter?.interactor)
        XCTAssertNotNil(sut?.presenter?.interactor?.presenter)
    }

}
