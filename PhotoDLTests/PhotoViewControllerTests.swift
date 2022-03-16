//
//  PhotoViewControllerTests.swift
//  photolodeTests
//
//  Created by Homayun on 12/9/1400 AP.
//  Copyright © 1400 AP Homayun. All rights reserved.
//

import XCTest
@testable import PhotoDL

class PhotoViewControllerTests: XCTestCase {
    
    var sut: PhotoViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testPhotoDownload_ImageOrientationIsIdentical() {
        let expectedImageOrientation = UIImage(named: "pexels-photo-768218")?.imageOrientation
        
        guard let url = URL(string: imageURLStrings[3]) else { XCTFail(); return }
        let sessionAnsweredExpectation = expectation(description: "Session")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            
            if let data = data {
                guard let image = UIImage(data: data) else { XCTFail(); return }
                sessionAnsweredExpectation.fulfill()
                XCTAssertEqual(image.imageOrientation, expectedImageOrientation)
            }
        }.resume()
        
        waitForExpectations(timeout: 20, handler: nil)
    }
    
}










