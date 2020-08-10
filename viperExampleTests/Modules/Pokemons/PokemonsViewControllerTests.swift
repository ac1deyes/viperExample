//
//  PokemonsViewControllerTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 28.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample

class PokemonsViewControllerTests: XCTestCase {
    
    var sut: PokemonsViewController!
    var presenter: MockPokemonsPresenter!
    var interactor: MockPokemonsInteractor!
    
    override func setUp() {
        presenter = MockPokemonsPresenter()
        interactor = MockPokemonsInteractor()
        
        sut = UIStoryboard.pokemonsViewController()
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
    
    func testWhenRefreshThenCallsPresenter() {
        sut.refresh()
        XCTAssertTrue(presenter.isRefreshing)
    }
    
    func testWhenSelectCellThenCallsPresenter() {
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 3, section: 0))
        XCTAssertEqual(presenter.didSelectRowIndex, 3)
    }
    
    func testWhenWillDisplayRowThenCallsPresenter() {
        sut.tableView(sut.tableView, willDisplay: UITableViewCell(), forRowAt: IndexPath(row: 4, section: 0))
        XCTAssertEqual(presenter.willDisplayRowIndex, 4)
    }
    
    func testWhenPresenterNilThenZeroNuberOfRows() {
        sut.presenter = nil
        XCTAssertTrue(sut.tableView(sut.tableView, numberOfRowsInSection: 0) == 0)
    }
    
    func testWhenFetchErrorThenStopsAnimation() {
        interactor.shouldFail = true
        sut.loadingActivityIndicatorView.startAnimating()
        presenter.fetchPokemonsFailure(error: MockError.someError, loadingType: .load)
        XCTAssertFalse(sut.loadingActivityIndicatorView.isAnimating)
    }
    
    func testWhenLoadSuccessTheProcessUI() {
        presenter.fetchPokemonsSuccess(pokemons: [], maxCount: 0, loadingType: .load)
        XCTAssertTrue(sut.refreshControl.isEnabled)
        XCTAssertFalse(sut.loadingActivityIndicatorView.isAnimating)
    }
    
    func testWhenRefreshThenProcessUI() {
        sut.refreshControl.beginRefreshing()
        presenter.fetchPokemonsSuccess(pokemons: [], maxCount: 0, loadingType: .refresh)
        XCTAssertFalse(sut.refreshControl.isRefreshing)
    }
    
    func testWhenDeselectRowThenProcell() {
        sut.tableView.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: .none)
        XCTAssertEqual(sut.tableView.indexPathForSelectedRow, IndexPath(row: 1, section: 0))
        sut.deselectRowAt(row: 1)
        XCTAssertNotEqual(sut.tableView.indexPathForSelectedRow, IndexPath(row: 1, section: 0))
    }
    
    func testWhenScrollThenLoadNext() {
        presenter.willDisplayRowAt(index: 47)
        XCTAssertFalse(sut.footerActivityIndicatorView.isAnimating)
    }
}
