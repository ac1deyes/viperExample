//
//  MockPokemonDetailView.swift
//  viperExampleTests
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
@testable import viperExample

class MockPokemonDetailViewController: PresenterToViewPokemonDetailProtocol {
    
    var isSuccess: Bool = false
    var loading: Bool = false
    
    var error: String?
    
    func onFetchPokemonSuccess() {
        isSuccess = true
    }
    
    func onFetchPokemonFailure(error: String) {
        self.error = error
        isSuccess = false
    }
    
    func showActivityIndicator() {
        loading = true
    }
    
    func hideActivityIndicator() {
        loading = false
    }
    
    func pokemonName(_ name: String?) {
    }
}
