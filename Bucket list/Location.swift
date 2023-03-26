//
//  Location.swift
//  Bucket list
//
//  Created by Harshit Agarwal on 26/03/23.
//

import Foundation
import CoreLocation

struct Location: Identifiable,Codable,Equatable{
    var id = UUID()
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinates: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let examples = Location(name: "Banke Bihari Temple", description: "Place where you can find peace", latitude: 27.582256, longitude: 77.697083)
    
    static func ==(lhs: Location,rhs: Location) ->  Bool{
        lhs.id == rhs.id
    }
    
}
