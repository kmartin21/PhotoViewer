//
//  Resource.swift
//  PhotoViewer
//
//  Created by keith martin on 8/23/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import Foundation

struct Resource<A> {
    let url: URL
    let method: HttpMethod
    let parse: (Data) -> A?
}

extension Resource {
    init(url: URL, method: HttpMethod = .get, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.method = method
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            return json.flatMap(parseJSON)
        }
    }
}

extension URLRequest {
    init<A>(resource: Resource<A>) {
        self.init(url: resource.url)
        httpMethod = resource.method.method
    }
}
