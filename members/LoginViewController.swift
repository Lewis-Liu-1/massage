//
//  LoginViewController.swift
//  MyMassage
//
//  Created by Lewis Liu on 30/6/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Utilities.customizeFilledButton(login)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func loginTapped(_ sender: Any) {
        let e = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let p = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print("about to check login: \(e) \(p)")
        let ok = UserInfo.login(e, p)
        if ok {
            self.transitionToHome1()
        }
        else{
            Utilities.showAlert(view: self, title:"Login", message: "error" )
        }
    }
    
    
        /*
        let credential = EmailAuthProvider.credential(withEmail: e, password: p)
        
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: {(authResult, error) in
            if let error = error {
                Utilities.showAlert(view: self, title:"Login", message: error.localizedDescription)// An error happened.
            }else{
                Utilities.showAlert(view: self, title:"Login", message: "user ok")// User re-authenticated.
            }
        })
        
        
        
        //
        Auth.auth().signIn(withEmail: e, password: p) { user, error in
            if error == nil && user != nil {
                self.transitionToHome1()
                //Utilities.showAlert(view: self, title:"Login", message: "user logged in")
                
            }
            else{
                Utilities.showAlert(view: self, title:"Login", message: "error" )
            }
            //if let error = error, let _ = AuthErrorCode(rawValue: //error._code) {
               // Utilities.showAlert(view: self, title:"Login", message: error.localizedDescription)
                //completionBlock(false)
            //} else {
            //    self.transitionToHome1()
                //completionBlock(true)
           // }
        }
        
        //Auth.auth().signIn(withEmail:e,password:p )
        //{ [weak self] authResult, error in
          //guard let strongSelf = self else { return }
            //self?.transitionToHome1()
            // ...
        //}
                    
        
                    
    }
    
    @IBAction func loginTapped1(_ sender: Any) {
        let e = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              let p = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              print("about to check login: \(e) \(p)")
              Auth.auth().signIn(withEmail:e,password:p){
                               (result,error) in
                if let error = error as? NSError {
                    var msg = ""
                    switch AuthErrorCode(rawValue: error.code) {
                    case .operationNotAllowed:
                        msg="operation not allowed"
                        break
                  // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                    case .userDisabled:
                        msg = " user disabled"
                        break
                  // Error: The user account has been disabled by an administrator.
                    case .wrongPassword:
                        msg = "wrong password"
                        break
                  // Error: The password is invalid or the user does not have a password.
                    case .invalidEmail:
                        msg="invalid email"
                        break
                  // Error: Indicates the email address is malformed.
                    default:
                        msg = error.localizedDescription
                    }
                    Utilities.showAlert(view: self, title:"Login", message: msg)
                }
                               //if error != nil {
                               //    Utilities.showAlert(view: self, title:"Login", message: error!.localizedDescription)
                               //
                               //}
                               else{
                                print("user logged in")
                                self.transitionToHome1()
                                }
        }
    }
    */
    
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
