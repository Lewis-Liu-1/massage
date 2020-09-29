//
//  ImageViewController.swift
//  NewMassage
//
//  Created by Lewis Liu on 5/8/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var imgView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        imgView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        imgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
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
