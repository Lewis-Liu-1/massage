//
//  MeViewController.swift
//  MyMassage
//
//  Created by Lewis Liu on 4/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit
import FirebaseAuth

class MeViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackContainer: UIStackView!
    
    @IBOutlet weak var usersField: UIButton!
    @IBOutlet weak var storesField: UIButton!
    @IBOutlet weak var staffField: UIButton!
    @IBOutlet weak var servicesField: UIButton!
    @IBOutlet weak var rewardsField: UIButton!
    @IBOutlet weak var logout: UIButton!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //view.backgroundColor = .lightGray
        // Do any additional setup after loading the view.
        Utilities.customizeFilledButton(logout)
        
        infoLabel.text = UserInfo.getMyInfo()
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 800)
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        stackContainer.frame = CGRect(x: (scrollView.width - size)/2,
                                      y: 50,
                                      width: size,
                                      height:size)
        usersField.disclosureButton(baseColor: view.tintColor)
        
        storesField.disclosureButton(baseColor: view.tintColor)
        staffField.disclosureButton(baseColor: view.tintColor)
        servicesField.disclosureButton(baseColor: view.tintColor)
        rewardsField.disclosureButton(baseColor: view.tintColor)
        //logout.disclosureButton(baseColor: view.tintColor)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logoutTapped(_ sender: Any) {
        //let defaults = UserDefaults.standard
        //UserDefaults.resetStandardUserDefaults()
        Utilities.signOut()
        //defaults.remov.removeObject(forKey: Constants.Storyboard.userLoginKey)
        do{
            try Auth.auth().signOut()
            //print("user signed out")
            self.transitionToHome2()
        }
        catch let signOutError{
            Utilities.showAlert(view: self, title: "User", message: signOutError.localizedDescription)
            
        }
    }
    func transitionToHome2(){
        // after login is done, maybe put this in the login web service completion block

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.Storyboard.nonMembersHomeViewController)
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        
    }
}
