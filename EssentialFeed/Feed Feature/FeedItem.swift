//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Eric Ho on 29/1/2023.
//

import Foundation

public struct FeedItem: Equatable {
    let id:UUID
    let description:String?
    let location:String?
    let imageURL:URL
}
