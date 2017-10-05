//
//  Photo.swift
//  PhotoViewer
//
//  Created by keith martin on 8/23/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import Foundation

struct Photo {
    let url: String
    let thumbnailUrl: String
}

extension Photo: JSONDecodable {
    init?(json: JSONObject) {
        guard let url = json["url"] as? String,
            let thumbnailUrl = json["thumbnailUrl"] as? String else { return nil }
        
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
