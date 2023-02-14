//
//  PlaceModel.swift
//  swiftbook-5-MyPlaces-002
//
//  Created by Влад on 14.02.23.
//

import Foundation

struct Place{
    let name: String
    let location: String
    let type: String
    let image: String
    
    static  let restaurantNames = ["AAA","BAA","CCB","ABC","CAB"]
    
    static func getPlace() -> [Place]{
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "Riga", type: "rest", image: place))
        }
        return places
    }
}
