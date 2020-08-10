//
//  PokemonLocalDataSource.swift
//  viperExample
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
import RealmSwift

class PokemonLocalDataSource: LocalDataSource {
    
    func get(id: Int, completionHandler: @escaping (Pokemon?, Error?) -> ()) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                
                let realmBackgroungThread = try! Realm()
                let pokemon: Pokemon? = realmBackgroungThread
                    .objects(Pokemon.self)
                    .filter("id == \(id)")
                    .first
                
                if let pokemon = pokemon {
                    let pokemonRef = ThreadSafeReference(to: pokemon)
                    DispatchQueue.main.async {
                        let realmMainThread = try! Realm()
                        let obj = realmMainThread.resolve(pokemonRef)
                        completionHandler(obj, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(nil, nil)
                    }
                }

            }
        }
    }
    
    func create(pokemon: Pokemon) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(pokemon, update: .modified)
        }
    }
}
