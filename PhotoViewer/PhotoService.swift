//
//  PhotoService.swift
//  PhotoViewer
//
//  Created by keith martin on 8/25/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import Foundation

class PhotoService {
    
    typealias PhotoServiceCompletion = ([Photo]?, Error?) -> ()
    private let networkManager: NetworkManager
    
    init() {
        networkManager = NetworkManager()
    }
    
    func fetchImages(completion: @escaping PhotoServiceCompletion) {
        networkManager.load(resource: Photo.all) { (photos, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(photos, nil)
        }
    }
}

extension Photo {
    static let all = Resource<[Photo]>(url: URL(string: NetworkingConstants.allPhotosUrl)!, parseJSON: { json in
        guard let dictionaries = json as? [JSONObject] else { return nil }
        return dictionaries.flatMap(Photo.init)
    })
}
