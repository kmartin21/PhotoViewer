//
//  PhotoTests.swift
//  PhotoViewer
//
//  Created by keith martin on 8/26/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import Nimble
import Quick

@testable import PhotoViewer

extension Photo {
    static func validJSON() -> JSONObject {
        return [
            "albumId": 1,
            "id": 1,
            "title": "accusamus beatae ad facilis cum similique qui sunt",
            "url": "http://placehold.it/600/92c952",
            "thumbnailUrl": "http://placehold.it/150/92c952"
        ]
    }
}

class PhotoTests: QuickSpec {
    
    override func spec() {
        describe("Photo") {
            var photo: Photo!
            var validJSON: JSONObject!
            
            beforeEach {
                validJSON = Photo.validJSON()
            }
            
            it("should parse all properties") {
                photo = Photo(json: validJSON)
                
                expect(photo.url) == "http://placehold.it/600/92c952"
                expect(photo.thumbnailUrl) == "http://placehold.it/150/92c952"
            }
            
            it("should not parse for missing URL") {
                validJSON.removeValue(forKey: "url")
                photo = Photo(json: validJSON)
                
                expect(photo).to(beNil())
            }
            
            it("should not parse for missing thumbnail URL") {
                validJSON.removeValue(forKey: "thumbnailUrl")
                photo = Photo(json: validJSON)
                
                expect(photo).to(beNil())
            }
        }
    }
}
