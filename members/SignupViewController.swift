//
//  SignupViewController.swift
//  MyMassage
//
//  Created by Lewis Liu on 2/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit

import Foundation

class SignupViewController: UIViewController {

    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var newGender: UISegmentedControl!
    
    @IBOutlet weak var firstname: UITextField!
    
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var passwordConfirm: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scroller)
        // Do any additional setup after the view
        Utilities.customizeFilledButton(signup)
        newGender.setTitle("Male", forSegmentAt: 0)
        newGender.setTitle("Female", forSegmentAt: 1)
        errorLabel.alpha = 0
    }

    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scroller.contentSize = CGSize(width: scroller.contentSize.width, height: 800)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func validateFields() ->String?{
        if firstname.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""
            ||
            ((lastname.text?.trimmingCharacters(in: .whitespacesAndNewlines))=="")
        ||
        ((email.text?.trimmingCharacters(in: .whitespacesAndNewlines))=="")
        ||
        ((password.text?.trimmingCharacters(in: .whitespacesAndNewlines))=="")
        ||
        ((passwordConfirm.text?.trimmingCharacters(in: .whitespacesAndNewlines))=="")
        {
            return "Please fill in all fields"
        }
    
        let cleanPassword=password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isValidPassword(cleanPassword) == false{
            return "Please make sure your password is at least 8 charaters, contains a special character and a number."
        }
        
        if password.text != passwordConfirm.text {
            return "Password not confirm with each other"
        }
        
        var number = Int(age.text!)
        if number == nil
        {
            return "invalid age"
        }
        number = Int(mobile.text!)
        if number == nil
        {
            return "invalid mobile"
        }
        
        return nil
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
            return
        }
        
        let cleanFirstname = firstname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanLastname = lastname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanAge = Int(age.text!)
        let cleanMobile = mobile.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanGender = self.newGender.titleForSegment(at:  self.newGender.selectedSegmentIndex)
        
        print("about to create user: \(cleanEmail) \(cleanPassword)")
        
        let ok = UserInfo.register(cleanEmail, cleanPassword, completion: {
            autherResult, success in
            let user = autherResult.user
                print("user: \(user)")
            
                if success {
                    let uid = autherResult.user.uid
                    print("user id is : \(user.uid)")
                    Utilities.signIn(cleanEmail)
                    let newuser = UserInfo()
                    newuser.age = cleanAge!
                    newuser.email = cleanEmail
                    newuser.first_name = cleanFirstname
                    newuser.last_name = cleanLastname
                    newuser.gender = cleanGender!
                    newuser.mobile = cleanMobile
                    newuser.uid = uid
                    UserInfo.save(email: cleanEmail, user:newuser)
                    self.transitionToHome1()
                }
                else{
                    Utilities.showAlert(view: self, title: "", message: "user register failed")
                }
            })
        if ok {
            
        }
        else{
        }
    }
    /*
        Auth.auth().createUser(withEmail: cleanEmail, password: cleanPassword){ (result, error) in
            if error == nil {
                //user created
                let db = Firestore.firestore()
                db.collection("users").addDocument(data:["first_name":cleanFirstname,
                    "last_name":cleanLastname,
                    "email":cleanEmail,
                    "age":cleanAge,
                    "gender":cleanGender,
                    "mobile":cleanMobile,
                    "uid":result!.user.uid])
                {
                                                            (error) in
                    if (error != nil){
                        self.showError("Error saving user data")
                    }
                }
                
                //Utilities.signIn(cleanEmail)
                Utilities.showAlert(view: self, title: "", message: "  user created: \(cleanEmail) \(cleanPassword)")
                //self.transitionToHome1()
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                     
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
        
    }
    */
    
    func showError(_ msg: String)
    {
        Utilities.showAlert(view: self, title:"New User", message: msg)
    }
    
    func transitionToHome1(){
        // after login is done, maybe put this in the login web service completion block

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.Storyboard.membersHomeViewController)
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        
    }
    

    
    func transitionToHome()
    {
        let hvc = storyboard?.instantiateViewController(identifier:Constants.Storyboard.homeViewController) as?
            HomeViewController
        view.window?.rootViewController = hvc
        view.window?.makeKeyAndVisible()
    }
}
