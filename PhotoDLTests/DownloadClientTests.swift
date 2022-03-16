//
//  DownloadClientTests.swift
//  photolodeTests
//
//  Created by Homayun on 12/9/1400 AP.
//  Copyright © 1400 AP Homayun. All rights reserved.
//

import XCTest
@testable import PhotoDL

class DownloadClientTests: XCTestCase {
    
    var sut: DownloadClient!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        sut = DownloadClient()
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDownload_UsesExpectedHost() {
        let imageUrl = imageURLStrings[3]
        sut.downloadImage(withURL: imageUrl)
        guard let url = URL(string: imageUrl) else { XCTFail(); return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.host, "images.pexels.com")
    }
    
    func testDownload_UsesExpectedPath() {
        let imageUrl = imageURLStrings[3]
        sut.downloadImage(withURL: imageUrl)
        guard let url = URL(string: "https://images.pexels.com/photos") else { XCTFail(); return }
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        XCTAssertEqual(urlComponents?.path, "/photos")
    }
}

extension DownloadClientTests {
    class MockURLSession: SessionProtocol {
        var url: URL?
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            return URLSession.shared.dataTask(with: url)
        }
    }
}
