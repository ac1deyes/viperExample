//
//  PokemonDetailPresenterTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample

class PokemonDetailPresenterTests: XCTestCase {
    
    var sut: PokemonDetailPresenter?
    var mockView: MockPokemonDetailViewController?
    var mockInteractor: MockPokemonDetailInteractor?
    
    override func setUp() {
        sut = PokemonDetailPresenter()
        mockView = MockPokemonDetailViewController()
        mockInteractor = MockPokemonDetailInteractor(pokemon: PokemonShort(name: "pokemon", url: "http:/test.de/10/"))
        mockInteractor?.presenter = sut
        sut?.view = mockView
        sut?.interactor = mockInteractor
        super.setUp()
    }
    
    override func tearDown() {
      sut = nil
      mockView = nil
      mockInteractor = nil
      super.tearDown()
    }
    
    func testWhenViewDidLoadThenFetchPokemon() {
        sut?.viewDidLoad()
        XCTAssertTrue(mockInteractor!.loading)
        XCTAssertNotNil(sut?.pokemon)
    }
    
    func testWhenViewDidDisappearThenStopFetching() {
        sut?.viewDidDisappear()
        XCTAssertFalse(mockInteractor!.loading)
    }
    
    func testWhenPokemonLoadThenNumberOfRowsMoreThenZero() {
        XCTAssertTrue(sut!.numberOfRowsInSection() == 0)
        sut?.viewDidLoad()
        XCTAssertTrue(sut!.numberOfRowsInSection() > 0)
    }
    
    func testWhenPokemonLoadThenTableViewTakesData() {
        sut?.viewDidLoad()
        let labels = PokemonDetailPresenter.PokemonRows.allCases.enumerated().map { (a, _) -> String? in
            return sut!.textLabelText(indexPath: IndexPath(row: a, section: 0))
        }
        
        let detailLabels = PokemonDetailPresenter.PokemonRows.allCases.enumerated().map { (a, _) -> String? in
            return sut!.detailTextLabelText(indexPath: IndexPath(row: a, section: 0))
        }
        
        XCTAssertEqual(labels.count, PokemonDetailPresenter.PokemonRows.allCases.count)
        XCTAssertEqual(detailLabels.count, PokemonDetailPresenter.PokemonRows.allCases.count)
    }
    
    func testWhenPokemonFetchErrorThenViewUpdates() {
        mockInteractor?.shouldFail = true
        mockInteractor?.loadPokemon()
        XCTAssertEqual(mockView?.error, MockError.pokemonNotExist.localizedDescription)
        XCTAssertFalse(mockView!.isSuccess)
        XCTAssertFalse(mockView!.loading)
    }
}
