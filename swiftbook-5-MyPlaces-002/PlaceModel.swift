//
//  PlaceModel.swift
//  swiftbook-5-MyPlaces-002
//
//  Created by Влад on 14.02.23.
//

import RealmSwift

struct Place{
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restaurantImage: String?
    
    static  let restaurantNames = ["AAA","BAA","CCB","ABC","CAB"]
    
    static func getPlace() -> [Place]{
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "Riga", type: "rest",image: nil ,restaurantImage: place))
        } 
        return places
    }
}
