//
//  AppDelegate+Injection.swift
//  viperExample
//
//  Created by Vladislav on 06.08.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    static let mock = Resolver(parent: main)
    
    public static func registerAllServices() {
        
        register { PokemonRemoteDataSource() }
        register { PokemonLocalDataSource() }
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            root = mock
        }
    }
}
