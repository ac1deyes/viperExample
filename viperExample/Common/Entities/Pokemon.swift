//
//  Pokemon.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
import RealmSwift

class Pokemon: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
    @objc dynamic var baseExperience: Int = 0
    
    @objc dynamic var weight:Int = 0
    @objc dynamic var height: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    init(id: Int, name: String, baseExperience: Int, weight: Int, height: Int) {
        self.id = id
        self.name = name
        self.baseExperience = baseExperience
        self.weight = weight
        self.height = height
    }
    
    required init() {
        super.init()
    }
}
