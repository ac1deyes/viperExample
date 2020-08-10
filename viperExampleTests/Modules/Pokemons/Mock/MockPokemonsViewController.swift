//
//  MockPokemonsViewController.swift
//  viperExampleTests
//
//  Created by Vladislav on 28.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
@testable import viperExample

class MockPokemonsViewController: PresenterToViewPokemonsProtocol {
    
    var isActivityVisible: Bool = false
    var isFooterActivityVisible: Bool = false
    
    var isRefreshWasDisabled: Bool = false
    var isRefreshWasEnabled: Bool = false
    var isRefreshDidEnd: Bool = false
    
    var isLoading: Bool = false
    var errorString: String?
    var deselectedRowIndex: Int?
    
    func onFetchPokemonsSuccess() {
        isLoading = false
    }
    
    func onFetchPokemonsFailure(error: String) {
        errorString = error
    }
    
    func showActivityIndicator() {
        isActivityVisible = true
    }
    
    func hideActivityIndicator() {
        isActivityVisible = false
    }
    
    func showFooterView() {
        isFooterActivityVisible = true
    }
    
    func hideFooterView() {
        isFooterActivityVisible = false
    }
    
    func endRefreshing() {
        isRefreshDidEnd = true
    }
    
    func disableRefresh() {
        isRefreshWasDisabled = true
    }
    
    func enableRefresh() {
        isRefreshWasEnabled = true
    }
    
    func deselectRowAt(row: Int) {
        deselectedRowIndex = row
    }
}
