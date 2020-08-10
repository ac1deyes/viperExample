//
//  Injected.swift
//  viperExample
//
//  Created by Vladislav on 06.08.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
import Resolver

@propertyWrapper
public struct Injected<Service> {
    private var service: Service
    public init() {
        self.service = Resolver.resolve(Service.self)
    }
    public init(name: String? = nil, container: Resolver? = nil) {
        self.service = container?.resolve(Service.self, name: name) ?? Resolver.resolve(Service.self, name: name)
    }
    public var wrappedValue: Service {
        get { return service }
        mutating set { service = newValue }
    }
    public var projectedValue: Injected<Service> {
        get { return self }
        mutating set { self = newValue }
    }
}
