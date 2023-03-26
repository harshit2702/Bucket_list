//
//  Result.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 26/03/23.
//

import Foundation

struct Result: Codable{
    let query: Query
}
struct Query: Codable{
    let pages: [Int: Page]
}

struct Page: Codable{
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
