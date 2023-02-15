//
//  NewTableViewController.swift
//  swiftbook-5-MyPlaces-002
//
//  Created by Влад on 14.02.23.
//

import UIKit

class NewPlaceViewController: UITableViewController, UINavigationControllerDelegate {
    
    var newPlace = Place()
    var imageIsChanged = false
    
    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    @IBOutlet var placeName: UITextField!
    @IBOutlet var placeLocation: UITextField!
    @IBOutlet var placeType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        DispatchQueue.main.async {
            self.newPlace.savePlaces()
        }
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(UIImage(systemName: "camera.circle.fill"), forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            
            
            let photo = UIAlertAction(title: "photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(UIImage(systemName: "photo.circle.fill"), forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            
            
            let cancel = UIAlertAction(title: "cancel", style: .cancel)
            //cancel.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        }else{
            view.endEditing(true)
        }
    }
    
    func saveNewPlace(){
        var image: UIImage?
        
        if imageIsChanged{
            image = placeImage.image
        }else{
            image = UIImage(systemName: "photo")
        }
//
//        newPlace = Place(name: placeName.text! ,
//                         location: placeLocation.text,
//                         type: placeType.text,
//                         image: image,
//                         restaurantImage: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any){
        dismiss(animated: true)
    }
}
//MARK: - Text field delegate

extension NewPlaceViewController: UITextFieldDelegate{
    
    //show keyboards tapped Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged(){
        if placeName.text?.isEmpty == false{
            saveButton.isEnabled = true
        }else{
            saveButton.isEnabled = false
        }
    }
   
}

//MARK: - Work with image

extension NewPlaceViewController: UIImagePickerControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        
        imageIsChanged = true
        
        dismiss(animated: true)
    }
    
}
