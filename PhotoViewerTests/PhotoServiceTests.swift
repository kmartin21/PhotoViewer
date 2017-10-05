//
//  PhotoServiceTests.swift
//  PhotoViewer
//
//  Created by keith martin on 8/26/17.
//  Copyright © 2017 Keith Martin. All rights reserved.
//

import Quick
import Nimble
import Mockingjay

@testable import PhotoViewer

class PhotoServiceTests: QuickSpec {
    
    override func spec() {
        describe("Request all photos") {
            var returnedPhotoData: [Photo]?
            var returnedError: Error?
            var photoService: PhotoService!
            
            beforeEach {
                photoService = PhotoService()
            }
            
            context("get") {
                
                it("should return photo data"){
                    let jsonObjectArray: [JSONObject] = [Photo.validJSON()]
                    
                    self.stub(everything, json(jsonObjectArray))
                    photoService.fetchImages(completion: { (photos, error) in
                        returnedPhotoData = photos
                    })
                    expect(returnedPhotoData).toEventuallyNot(beNil())
                }
                
                it("should return an error") {
                    let error = NSError(domain: "error", code: 404, userInfo: nil)

                    self.stub(everything, failure(error))
                    photoService.fetchImages(completion: { (photos, error) in
                        returnedError = error
                    })
                    expect(returnedError).toEventuallyNot(beNil())
                }
            }
        }
    }
}
