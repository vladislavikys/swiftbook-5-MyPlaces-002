//
//  PlaceModel.swift
//  swiftbook-5-MyPlaces-002
//
//  Created by Влад on 14.02.23.
//

import RealmSwift

class Place: Object{
    
    @objc dynamic var name = ""
    @objc dynamic  var location: String?
    @objc dynamic var type: String?
    @objc dynamic  var imageData: Data?
    @objc dynamic var restaurantImage: String?
    
    let restaurantNames = ["ABA","BAA","CCB","ABC","CAB"]
    
    func savePlaces(){
        
        for place in restaurantNames {
            
            let image = UIImage(named: place)
            let imageData = image?.pngData() 
            
            let newPlace = Place()
            
            newPlace.name = place
            newPlace.location = "Riga"
            newPlace.type = "REst"
            newPlace.imageData = imageData
            
            StorageManager.saveObject(newPlace)
        }
    }
}
