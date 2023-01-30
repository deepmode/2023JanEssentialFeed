//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Eric Ho on 30/1/2023.
//

import Foundation

//note: The <HTTPClient> does not need to be a class. It is just a contract defining which external functionality the RemoteFeedLoader needs, so a protocol is a more suitable way to define it.
//note: By creating a clean separation with protocols, we made the RemoteFeedLoader more flexible, open for extension and more testable.
public protocol HTTPClient {
    func get(from url:URL)
}


final public class RemoteFeedLoader {

    private let url:URL
    private let client:HTTPClient

    public init(url:URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
        //note: Move the test logic from RemoteFeedLoader to HTTPClient
        client.get(from: url)
        //client.get(from: url) //note: mistakes like this happen all the time (especially when merging code) 
    }
}
