//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Eric Ho on 29/1/2023.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (FeedLoaderResult) -> Void)
}
