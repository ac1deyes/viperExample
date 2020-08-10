//
//  NetworkDataFetcherTests.swift
//  viperExampleTests
//
//  Created by Vladislav on 28.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import XCTest
@testable import viperExample

class NetworkDataFetcherTests: XCTestCase {

    var sut: NetworkDataFetcher?
    
    override func setUp() {
        sut = NetworkDataFetcher()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testWhenUnexpectedDataThenProcessSuccess() {
        let expectation = self.expectation(description: "Network")
        var expectedError: Error?
        
        sut?.request(endpoint: .pokemon(1000), method: .get, completionHandler: { (response, error) in
            expectedError = error
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNotNil(expectedError)
    }

    func testWhenCancelRequestThenNoCrash() {
        sut?.cancelRequest(.pokemon(9))
    }

}
