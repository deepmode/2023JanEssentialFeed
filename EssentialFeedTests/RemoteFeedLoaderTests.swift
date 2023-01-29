//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Eric Ho on 29/1/2023.
//

import XCTest

final class RemoteFeedLoaderTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    class RemoteFeedLoader {
        
        func load() {
            HTTPClient.shared.requestedURL = URL(string: "https://a-url.com")
        }
    }
    
    class HTTPClient {
        
        var requestedURL:URL?
        
        static let shared = HTTPClient()
        
        private init() {}
        
    }
    
    
    func test_init_doesNotRequestDataFromURL() {
        
        //note: some kind of client to handle network call or requesting data from url
        let client = HTTPClient.shared
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        
        //Arrange
        let client = HTTPClient.shared
        let sut = RemoteFeedLoader()
        
        //note: 3 types of injection
        //1. constructor injection e.g. RemoteFeedLoader(client: XXX)
        //2. property injection e.g. sut.client = XXX
        //3. method injection e.g. sut.load(client: XXX)
        
        //Act
        sut.load()
        
        //Assert
        XCTAssertNotNil(client.requestedURL)
    }

}
