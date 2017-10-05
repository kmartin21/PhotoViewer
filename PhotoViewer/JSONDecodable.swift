//
//  JSONDecodable.swift
//  PhotoViewer
//
//  Created by keith martin on 8/23/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import Foundation

typealias JSONObject = [String: Any]

protocol JSONDecodable {
    init?(json: JSONObject)
}
