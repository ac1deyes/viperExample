//
//  PokemonsPresenterTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 28.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample

fileprivate let pokemonsCount = 50
fileprivate let pokemonsLeftBeforeLoadNext = 3
fileprivate let indexToStartLoadNext = pokemonsCount - pokemonsLeftBeforeLoadNext

class PokemonsPresenterTests: XCTestCase {
    
    var sut: PokemonsPresenter!
    var mockViewController: MockPokemonsViewController!
    var mockInteractor: MockPokemonsInteractor!
    var mockRouter: MockPokemonsRouter!
    
    override func setUp() {
        sut = PokemonsPresenter()
        mockViewController = MockPokemonsViewController()
        mockInteractor = MockPokemonsInteractor()
        mockRouter = MockPokemonsRouter()
        
        mockInteractor.presenter = sut
        sut.view = mockViewController
        sut.interactor = mockInteractor
        sut.router = mockRouter
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        mockInteractor = nil
        mockViewController = nil
        super.tearDown()
    }
    
    func testWhenViewDidLoadThenFetchPokemons() {
        sut.viewDidLoad()
        XCTAssertTrue(mockInteractor!.isLoading)
    }
    
    func testWhenLoadingThenDisableRefresh() {
        sut.viewDidLoad()
        XCTAssertTrue(mockViewController.isRefreshWasDisabled)
    }
    
    func testWhenLoadingEndsThenEnableRefresh() {
        sut.viewDidLoad()
        XCTAssertTrue(mockViewController.isRefreshWasEnabled)
    }
    
    func testWhenScrollingThenLoadNextStartsCorrectly() {
        sut.viewDidLoad()
        sut.willDisplayRowAt(index: 40)
        XCTAssertFalse(mockInteractor.isLoadingNext)
        sut.willDisplayRowAt(index: indexToStartLoadNext)
        XCTAssertTrue(mockInteractor.isLoadingNext)
    }
    
    func testWhenLoadingNextThenRefreshCancelsLoad() {
        sut.viewDidLoad()
        mockInteractor.shouldSimulateResponseAwaiting = true
        sut.willDisplayRowAt(index: indexToStartLoadNext)
        sut.refresh()
        XCTAssertTrue(mockInteractor.isRequestsCanceled)
    }
    
    func testWhenRefreshThenProcessCorrectly() {
        sut.viewDidLoad()
        sut.willDisplayRowAt(index: indexToStartLoadNext)
        XCTAssertEqual(mockInteractor.currentPokemons.count, 100)
        mockInteractor.shouldFail = true
        sut.refresh()
        XCTAssertEqual(mockInteractor.currentPokemons.count, 100)
        mockInteractor.shouldFail = false
        sut.refresh()
        XCTAssertEqual(mockInteractor.currentPokemons.count, 50)
    }
    
    func testWhenDidSelectRowThenRetrieveStarts() {
        sut.viewDidLoad()
        sut.didSelectRowAt(index: 1)
        XCTAssertTrue(mockInteractor.isRetrieving)
    }
    
    func testWhenDidSelectRowWrongIndexThenRouterShowError() {
        sut.viewDidLoad()
        sut.didSelectRowAt(index: 55)
        XCTAssertTrue(mockRouter.didShowError)
    }
    
    func testWhenDidSelectRowThenPushesToDetailView() {
        sut.viewDidLoad()
        sut.didSelectRowAt(index: 1)
        XCTAssertTrue(mockRouter.didPush)
    }
    
    
    func testWhenLoadingFailThenProcess() {
        mockInteractor.shouldFail = true
        sut.viewDidLoad()
        XCTAssertTrue(mockViewController.isRefreshWasEnabled)
        XCTAssertFalse(mockViewController.isActivityVisible)
    }
    
    func testWhenRefreshFailThenProcess() {
        sut.viewDidLoad()
        mockInteractor.shouldFail = true
        sut.refresh()
        XCTAssertTrue(mockViewController.isRefreshDidEnd)
    }
    
    func testWhenLoadNextFailThenProcess() {
        sut.viewDidLoad()
        mockInteractor.shouldFail = true
        sut.willDisplayRowAt(index: indexToStartLoadNext)
        XCTAssertFalse(mockViewController.isFooterActivityVisible)
    }
    
    func testWhenDidSelectRowThenDeselectRow() {
        let rowIndex = 10
        sut.viewDidLoad()
        sut.didSelectRowAt(index: rowIndex)
        XCTAssertEqual(mockViewController.deselectedRowIndex, rowIndex)
    }
}
