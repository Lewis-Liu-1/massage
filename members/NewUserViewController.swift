//
//  NewUserViewController.swift
//  MyMassage
//
//  Created by Lewis Liu on 27/6/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit
import Firebase

import FirebaseAuth
import os

//UIViewController
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

class NewUserViewController: UIViewController {

    @IBOutlet weak var newGender: UISegmentedControl!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    @IBAction func newCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
  
    @IBAction func save(_ sender: UIBarButtonItem) {
     
        if password.text != passwordConfirm.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
                if error == nil {
                    let u=user
                    let gender = self.newGender.titleForSegment(at: self.newGender.selectedSegmentIndex)
                    let ag=self.age.text
                    
                    Analytics.setUserProperty("pizza", forName: "favorite_food")
                    Analytics.setUserProperty(gender, forName: "gender")
                    Analytics.setUserProperty(ag, forName: "age")
                   let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = self.userName.text
                    
                    changeRequest?.commitChanges()
                    
                    //self.showToast(message: "User has been created!", font: .systemFont(ofSize: 12.0))
                    let alert = UIAlertController(title: "User Created!", message: "Welcome to Massage World.", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true)
                    
                    
                    //self.performSegue(withIdentifier: "loginForm", sender: self)
                    //print("user created")
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
           
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
         

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        newGender.setTitle("Male", forSegmentAt: 0)
        newGender.setTitle("Female", forSegmentAt: 1)
        //entrada.setTitle("Action 3", forSegmentAt: 2)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
