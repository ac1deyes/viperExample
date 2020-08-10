//
//  Endpoint.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

enum Endpoint {
    case pokemonList(offset: Int, limit: Int)
    case pokemon(_ id: Int)
    
    var urlString: String {
        return "https://pokeapi.co/api/v2/" + stringValue
    }
    
    private var stringValue: String {
        switch self {
        case .pokemonList(let offset, let limit):   return "pokemon/?offset=\(offset)&limit=\(limit)"
        case .pokemon(let id):                      return "pokemon/\(id)"
        }
    }
}
