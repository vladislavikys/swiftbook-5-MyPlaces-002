//
//  MainViewController.swift
//  swiftbook-5-MyPlaces-002
//
//  Created by Влад on 14.02.23.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var places: Results<Place>!
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        places = realm.objects(Place.self)
    }

    // MARK: - Table view data source
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.isEmpty ? 0 : places.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let place = places[indexPath.row]
        
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
        
        return cell
    }
    
    //MARK: - Table view delegate
     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let place = places[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "delete") { (_, _) in
            
            StorageManager.deleteObject(place: place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return[deleteAction]
    }
    
    //MARK : - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let place = places[indexPath.row]
            let newPlaceVC = segue.destination as! NewPlaceViewController
            newPlaceVC.currentPlace = place
            
        }
    }
    
    @IBAction func unwindSegue(_ segue:UIStoryboardSegue){
        guard let newPlaceVC = segue.source as? NewPlaceViewController else {return}
        
        newPlaceVC.savePlace()
        tableView.reloadData()
        
    }
    
}
