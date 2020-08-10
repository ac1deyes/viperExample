//
//  MockPokemonsRouter.swift
//  viperExampleTests
//
//  Created by Vladislav on 28.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import UIKit
@testable import viperExample

class MockPokemonsRouter: PresenterToRouterPokemonsProtocol {
    
    var didPush: Bool = false
    var didShowError: Bool = false
    
    static func createModule() -> UINavigationController {
        return UINavigationController()
    }
    
    func pushToPokemonDetail(on view: PresenterToViewPokemonsProtocol, with pokemon: PokemonShort, animated: Bool) {
        didPush = true
    }
    
    func showError(_ error: Error, on view: PresenterToViewPokemonsProtocol) {
        didShowError = true
    }
}
