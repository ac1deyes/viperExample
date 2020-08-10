//
//  RemoteDataSource.swift
//  viperExample
//
//  Created by Vladislav on 09.08.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation

protocol RemoteDataSource {
    associatedtype T
    associatedtype I
    
    func fetchList(offset: Int, limit: Int, completionHandler: @escaping ([T]?, Int, Error?) -> ())
    func cancelFetchList(offset: Int ,limit: Int)

    func fetch(id: Int, completionHandler: @escaping (I?, Error?) -> ())
    func cancel(id: Int)
}
