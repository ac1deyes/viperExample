//
//  LocalDataSource.swift
//  viperExample
//
//  Created by Vladislav on 09.08.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

protocol LocalDataSource {
    associatedtype T
    func get(id: Int, completionHandler: @escaping (T?, Error?) -> ())
    func create(pokemon: T)
}
