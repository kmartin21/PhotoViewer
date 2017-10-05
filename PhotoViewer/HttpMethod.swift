//
//  HttpMethod.swift
//  PhotoViewer
//
//  Created by keith martin on 8/25/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import Foundation

enum HttpMethod {
    case get
}

extension HttpMethod {
    var method: String {
        switch self {
            case .get: return "GET"
        }
    }
}
