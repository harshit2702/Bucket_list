//
//  Location.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 26/03/23.
//

import Foundation

struct Location: Identifiable,Codable,Equatable{
    let id = UUID()
    var name: String
    var discription: String
    let latitude: Double
    let longitude: Double
}
