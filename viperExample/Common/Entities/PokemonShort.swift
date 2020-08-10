//
//  PokemonShort.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

struct PokemonShort: Decodable {
    var id: Int { return Int(URL(string: url)!.lastPathComponent)! }
    
    let name: String
    let url: String
}
