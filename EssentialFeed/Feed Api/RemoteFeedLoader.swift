//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Eric Ho on 30/1/2023.
//

import Foundation

final public class RemoteFeedLoader {

    private let url:URL
    private let client:HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(RemoteFeedLoader.Error)
    }

    public init(url:URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (RemoteFeedLoader.Result) -> Void) {
        //note: Move the test logic from RemoteFeedLoader to HTTPClient
        client.get(from: url) { result in
            //map the HTTPClient error into domain specific error (e.g. connectivity error)
            
            switch result {
            
            case let .success(data, response):
                completion(FeedItemsMapper.map(data, response: response))
                
            case .failure(let error):
                completion(.failure(.connectivity))
                
            }
        }
    }
    

}





