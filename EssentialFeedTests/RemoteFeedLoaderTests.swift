//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Eric Ho on 29/1/2023.
//

import XCTest

//note: can do "@testable import EssentialFeed" (not a prefer way instead ...
//note: a better a apporach, when possible, is to test the module through the public interfaces (via public class, public method, public protocol etc), so we can test the expected behavior as a client of the module. Another Benefit: we're free to change internal and private implmentation details without breaking the tests.
import EssentialFeed


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
    
    //note: test (test), init (the method), doesNotRequestDataFromURL (the behaviors we are tested)
    func test_init_doesNotRequestDataFromURL() {
        
        //note: some kind of client to handle network call or requesting data from url
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        
        //Arrange
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        //note: 3 types of injection
        //1. constructor injection e.g. RemoteFeedLoader(client: XXX)
        //2. property injection e.g. sut.client = XXX
        //3. method injection e.g. sut.load(client: XXX)
        
        //Act
        //note: When testing objects collaborating, asserting the values passwd is not enough. We also need to ask "How many times was the method invoked?"
        sut.load()
        
        //Assert
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURL() {
        
        //Arrange
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        //Act
        //note: When testing objects collaborating, asserting the values passwd is not enough. We also need to ask "How many times was the method invoked?"
        sut.load()
        sut.load()
        
        //Assert
        //note: assrt equality, counts at once
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        
        //note: Arrange: Given the sut and its HTTP client spy.
        let (sut, client) = makeSUT()
       
        
        //note: Act: When we tell the sut to load and we complete the client's HTTP request with an error
        //note: load ->  HTTP client spy captures the completion. The completion happen after the load call (e.g. load -> completion)
        var capturedErrors = [RemoteFeedLoader.Error]()
        print("step 1")
        sut.load {
            //append the return error
            print("step 3")
            //capture the return error (via HTTP Client (Spy one)'s completion)
            capturedErrors.append($0)
        }
        
        let clientError = NSError(domain: "Test", code: 0)
        print("step 2: execute the completion block with given clientError")
        client.completions[0](clientError)
        
        
        //note: Assert: Then we expect the captured load error to be a connectivity error.
        print("step 4")
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        return (RemoteFeedLoader(url: url, client: client), client)
    }
    
    class HTTPClientSpy: HTTPClient {
        
        var requestedURLs:[URL] = []
//        var error:Error?
        var completions = [(Error) -> Void]()
        
        func get(from url: URL, completion: @escaping (Error) -> Void) {
            
//            if let error = error {
//                completion(error)
//            }
            
            //note: capture the completion
            completions.append(completion)
            requestedURLs.append(url)
        }
    }

}

