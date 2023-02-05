//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Eric Ho on 30/1/2023.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

//note: The <HTTPClient> does not need to be a class. It is just a contract defining which external functionality the RemoteFeedLoader needs, so a protocol is a more suitable way to define it.
//note: By creating a clean separation with protocols, we made the RemoteFeedLoader more flexible, open for extension and more testable.
public protocol HTTPClient {
    func get(from url:URL, completion: @escaping (HTTPClientResult) -> Void)
}


final public class RemoteFeedLoader {

    private let url:URL
    private let client:HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public init(url:URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error) -> Void) {
        //note: Move the test logic from RemoteFeedLoader to HTTPClient
        client.get(from: url) { result in
            //map the HTTPClient error into domain specific error (e.g. connectivity error)
            
            switch result {
            case .failure(let error):
                completion(.connectivity)
            case .success(let response):
                completion(.invalidData)
            }
            
            //completion(.connectivity) //note: failing test: checking how many times the completion is invoked are important.
        }
    }
}
