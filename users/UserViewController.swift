//
//  UserViewController.swift
//  FoodTracker
//
//  Created by Lewis Liu on 9/6/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit
import os.log

class UserViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    var User:User?
    
    @IBOutlet weak var UserNameLabel: UILabel!
    //@IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: Actions
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    //@IBAction func cancel(_ sender: UIBarButtonItem) {
     //   dismiss(animated: true, completion: nil)
    //}
    
    @IBAction func newCancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddUserMode = presentingViewController is UINavigationController
        
        if isPresentingInAddUserMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The UserViewController is not inside a navigation controller.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Set up views if editing an existing User.
        if let User = User {
            navigationItem.title = User.name
            nameTextField.text   = User.name
            photoImageView.image = User.photo
            ratingControl.rating = User.rating
        }
        
        // Enable the Save button only if the text field has a valid User name.
        updateSaveButtonState()
    }


    /*@IBAction func setDefaultLabelText(_ sender: UIButton) {
        UserNameLabel.text="Default Text"
    }
    */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        //textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //UserNameLabel.text=textField.text
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide the keyboard
        //nameTextField.resignFirstResponder();
        
        //UIImagePIckerController is a view controller that lets a //user pick media from their photo library
        
        let imagePickerController=UIImagePickerController()
        
        //only allow photos to be picked, no taken
        imagePickerController.sourceType  = UIImagePickerController.SourceType.photoLibrary
        //make sure viewcontroller is notified when user picks an image
        imagePickerController.delegate = self
        present(imagePickerController,animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        ;
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard  let selectedImage=info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            fatalError("Expected a dictionary containning image, but was provided the following:\(info)")
        }
        
        photoImageView.image=selectedImage
        
        dismiss(animated:true, completion: nil)
        
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
    
        // Set the User to be passed to UserTableViewController after the unwind segue.
        //newUser = User(name: name, photo: photo, rating: rating)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
}

