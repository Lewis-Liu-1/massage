//
//  ViewController.swift
//  NewMassage
//
//  Created by Lewis Liu on 11/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //register()
        //login()
        //logout()
    }
    
    func register(){
        FirebaseAuth.Auth.auth().createUser(withEmail: "lewis@gmail.com", password: "Password", completion: {autherResult, error in
            guard let result = autherResult, error == nil else{
                print("user creation failed")
                return
            }
            let user = result.user
            print("user: \(user)")
        })
    }
    
    func login(){
        FirebaseAuth.Auth.auth().signIn(withEmail: "lewis@gmail.com", password: "Password", completion: {autherResult, error in
            guard let result = autherResult, error == nil else{
                print("user login failed")
                return
            }
            let user = result.user
            print("user logged in: \(user)")
        })
        
    }
    
    func logout()
    {
        print("hello world")
        do{
            try FirebaseAuth.Auth.auth().signOut()
            print("user signed out")
        }catch let error{
            print("failed sign out: \(error)")
        }
        
    }
    
    
}

