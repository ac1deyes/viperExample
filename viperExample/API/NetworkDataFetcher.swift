//
//  APIClient.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import Foundation
import Alamofire

class NetworkDataFetcher {
    
    private var session = Session.default
    
    typealias JSONObject = [String: Any]
    
    func request(endpoint: Endpoint, method: HTTPMethod, parameters: [String: Any] = [:], encoding: ParameterEncoding = JSONEncoding.default,
                 completionHandler: @escaping (JSONObject, Error?) -> ()) {
        
        session
            .request(endpoint.urlString,
                     method: method,
                     encoding: encoding)
            .validate()
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let json):
                    completionHandler(json as? JSONObject ?? [:], nil)
                case .failure(let error):
                    completionHandler([:], error)
                }
            })
    }
    
    func cancelRequest(_ endpoint: Endpoint) {
        session.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            let request = dataTasks.first { $0.originalRequest?.url?.absoluteString == endpoint.urlString }
            request?.cancel()
        }
    }
}

