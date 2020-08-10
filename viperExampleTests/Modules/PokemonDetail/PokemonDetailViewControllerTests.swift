//
//  PokemonDetailViewControllerTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample

class PokemonDetailViewControllerTests: XCTestCase {

    var sut: PokemonDetailViewController!
    var presenter: MockPokemonDetailPresenter!
    var interactor: MockPokemonDetailInteractor!
    
    override func setUp() {
        presenter = MockPokemonDetailPresenter()
        interactor = MockPokemonDetailInteractor(pokemon: PokemonShort(name: "pokemon", url: "http:/test.de/10/"))
        
        sut = UIStoryboard.pokemonDetailViewController()
        sut.presenter = presenter
        sut.presenter?.view = sut
        sut.presenter?.interactor = interactor
        sut.presenter?.interactor?.presenter = presenter
        sut.loadViewIfNeeded()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        presenter = nil
        interactor = nil
        super.tearDown()
    }
    
    func testWhenViewDidLoadThenCallsPresenter() {
        sut.viewDidLoad()
        XCTAssertTrue(presenter.isViewDidLoad)
    }
    
    func testWhenViewDidLoadThenSetName() {
        XCTAssertNotNil(sut.navigationItem.title)
        XCTAssertEqual(sut.navigationItem.title, presenter.interactor?.pokemon.name)
    }
    
    func testWhenViewDidDisappearThenCallsPresenter() {
        sut.viewDidDisappear(false)
        XCTAssertTrue(presenter.isViewDidDisappear)
    }
    
    func testWhenPokemonFetchedThenTableViewReload() {
        sut.viewDidLoad()
        XCTAssertTrue(presenter.isViewDidLoad)
        sut.tableView.setNeedsLayout()
        sut.tableView.layoutIfNeeded()
        XCTAssertTrue(sut.tableView.visibleCells.count == 3)
    }
    
    func testWhenPresenterNilThenZeroNuberOfRows() {
        sut.presenter = nil
        XCTAssertTrue(sut.tableView(sut.tableView, numberOfRowsInSection: 0) == 0)
    }
    
    func testWhenFetchErrorThenProcess() {
        interactor.shouldFail = true
        presenter.viewDidLoad()
        XCTAssertEqual(MockError.pokemonNotExist.localizedDescription, sut.errorLabel.text)
    }
}
