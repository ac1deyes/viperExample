//
//  Dictionary + Extensions.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

extension Dictionary {
    func decode<T: Decodable>(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        let data = try JSONSerialization.data(withJSONObject: self, options: [])
        let pokemon = try decoder.decode(T.self, from: data)
        return pokemon
    }
}
