//
//  MockError.swift
//  viperExampleTests
//
//  Created by Vladislav on 27.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

enum MockError: String, Error {
    case pokemonNotExist = "Pokemon not exist"
    case someError = "Some Error"
}
