//
//  StorageManager.swift
//  swiftbook-5-MyPlaces-002
//
//  Created by Влад on 15.02.23.
//

import RealmSwift


let realm = try! Realm()

class StorageManager{
    
    static func saveObject(_ place: Place){
        
        try! realm.write{
            realm.add(place)
        }
    }
    static func deleteObject( place: Place){
        
        try! realm.write{
            realm.delete(place)
        }
    }
}
