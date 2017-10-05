//
//  NetworkManager.swift
//  PhotoViewer
//
//  Created by keith martin on 8/23/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case NoHTTPResponse
    case DataNotReceived
    case BadStatus(status: Int)
    case Other(NSError)
}

class NetworkManager {
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration)
    }
    
    func load<T>(resource: Resource<T>, completion: @escaping ((T?, Error?) -> ())) {
        let request = URLRequest(resource: resource)
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, NetworkError.Other(error as NSError))
            } else {
                guard let HTTPResponse = response as? HTTPURLResponse else {
                    completion(nil, NetworkError.NoHTTPResponse)
                    return
                }
                guard let responseData = data else {
                    completion(nil, NetworkError.DataNotReceived)
                    return
                }
                if 200 ..< 300 ~= HTTPResponse.statusCode {
                    completion(resource.parse(responseData), nil)
                } else {
                    completion(nil, NetworkError.BadStatus(status: HTTPResponse.statusCode))
                }
            }
        }.resume()
    }
}
