//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Eric Ho on 29/1/2023.
//

import XCTest

class RemoteFeedLoader {

    let url:URL
    let client:HTTPClient

    init(url:URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        //note: Move the test logic from RemoteFeedLoader to HTTPClient
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url:URL)
}


class HTTPClientSpy: HTTPClient {
    
    var requestedURL:URL?
    
    func get(from url:URL) {
        requestedURL = url
    }
}



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
    
    
    func test_init_doesNotRequestDataFromURL() {
        
        //note: some kind of client to handle network call or requesting data from url
        let url = URL(string: "https://a-url.com")!
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(url: url, client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        
        //Arrange
        let url = URL(string: "https://a-given-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url:url, client: client)
        
        //note: 3 types of injection
        //1. constructor injection e.g. RemoteFeedLoader(client: XXX)
        //2. property injection e.g. sut.client = XXX
        //3. method injection e.g. sut.load(client: XXX)
        
        //Act
        sut.load()
        
        //Assert
        XCTAssertEqual(client.requestedURL, url)
    }

}

