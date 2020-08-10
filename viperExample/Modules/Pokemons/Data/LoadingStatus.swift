//
//  LoadingStatus.swift
//  viperExample
//
//  Created by Vladislav on 28.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

enum LoadingStatus {
    case none
    case loading(LoadingType)
}

extension LoadingStatus: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch lhs {
        case .none:
            switch rhs {
            case .none: return true
            case .loading(_): return false
            }
        case .loading(let lhsType):
            switch rhs {
            case .none: return false
            case .loading(let rhsType): return lhsType == rhsType
            }
        }
    }
}
