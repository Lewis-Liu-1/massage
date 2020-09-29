//
//  Utilities.swift
//  MyMassage
//
//  Created by Lewis Liu on 1/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//
//
import Foundation
import UIKit

class Utilities{
    static func customizeTxtField(_ textfield: UITextField)
    {
        let bottomLine=CALayer()
        bottomLine.frame=CGRect(x:0, y:textfield.frame.height-2, width: textfield.frame.width,
                                    height: 2)
        bottomLine.backgroundColor=UIColor.init(red:48/255,
            green:173/255, blue:99/255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func customizeFilledButton(_ button:UIButton)
    {
        button.backgroundColor=UIColor.init(red: 48/255,
                                            green: 173/255, blue:99/255, alpha: 1)
        button.layer.cornerRadius=25.0
        button.tintColor=UIColor.white
    }

    static func isValidPassword(_ password:String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    static func signedInBefore() ->Bool{
        let prefs = UserDefaults.standard
        let keyValue = prefs.string(forKey: Constants.Storyboard.userLoginKey)
        if keyValue==nil {
            return false
        }
        return true
    }
    
    static func signIn(_ email:String){
        let prefs = UserDefaults.standard
        let keyValue = prefs.string(forKey: Constants.Storyboard.userLoginKey)
        print("Key Value not set \(keyValue)")
        let strHello = email

        prefs.set(strHello, forKey: Constants.Storyboard.userLoginKey)
        let keyValue1 = prefs.string(forKey: Constants.Storyboard.userLoginKey)!
        print("Key Value \(keyValue1)")
    }
    static func signOut()
    {
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey: Constants.Storyboard.userLoginKey)
        let keyValue = prefs.string(forKey: Constants.Storyboard.userLoginKey)
        print("Key Value after remove \(keyValue)")
    }
    
    static func showAlert( view: UIViewController, title: String, message: String) {
        // Create alert controller.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        // Create alert action to add to controller.
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil);
        
        // Add action.
        alertController.addAction(alertAction);
        
        // Display alert.
        view.present(alertController, animated: true, completion: nil);
    }
}
