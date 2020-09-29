//
//  NewMeViewController.swift
//  NewMassage
//
//  Created by Lewis Liu on 31/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit

class NewMeViewController: UIViewController {
    let labelOne: UILabel = {
        let label = UILabel()
        label.text = UserInfo.getMyInfo()
        //label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelTwo: UILabel = {
        let label = UILabel()
        label.text = UserInfo.getMyInfo()
        //label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mainView: UIStackView=UIStackView()
    
    var buttons:[UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        
        self.view.addSubview(labelOne)
        NSLayoutConstraint(item: labelOne, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: labelOne, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200).isActive = true
        NSLayoutConstraint(item: labelOne, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: labelOne, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        
        
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 90, width: screenWidth, height: screenHeight))
        
        scrollView.addSubview(labelTwo)
        
        NSLayoutConstraint(item: labelTwo, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leadingMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: labelTwo, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200).isActive = true
        NSLayoutConstraint(item: labelTwo, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .topMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: labelTwo, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        
        scrollView.contentSize = CGSize(width: screenWidth, height: 1000)
        view.addSubview(scrollView)
        
        //let mainView=UIStackView()
        scrollView.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        //mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        mainView.spacing = 10
        
        mainView.alignment = .fill
        mainView.distribution = .fillEqually
        mainView.spacing = 8.0
        
        let names = [Constants.Table.users, Constants.Table.stores, Constants.Table.services, Constants.Table.staffs]
        
        createButtons(names: names)
        
        let top = labelTwo.bottomAnchor// NSLayoutYAxisAnchor(). view.topAnchor + 40
        
        var i=1.0
        for e in buttons{
            mainView.addSubview(e)
            
            e.topAnchor.constraint(equalTo:top, constant: CGFloat(40*i+10)).isActive = true
            e.leftAnchor.constraint(equalTo:mainView.leftAnchor, constant:20).isActive = true
            e.rightAnchor.constraint(equalTo:mainView.rightAnchor, constant:-20).isActive = true
            e.heightAnchor.constraint(equalToConstant: 30).isActive = true
            e.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 1)
            i = i + 1
        }
        
        //scrollView.isUserInteractionEnabled = false
        //mainView.isUserInteractionEnabled = false
        scrollView.delaysContentTouches = true
        
    }
    func createButtons(names: [String])
    {
        buttons=[UIButton]()
        
        for n in names {
            let newButton:UIButton = {
                let btn = UIButton(type:.system)
                btn.backgroundColor = .lightGray
                btn.setTitleColor(UIColor.black, for: .normal)
                //btn.setTitleColor(UIColor.blue, for: .highlighted)
                btn.setTitle(n, for: .normal)
                //btn.tintColor = .black
                btn.layer.cornerRadius = 5
                btn.clipsToBounds = true
                btn.translatesAutoresizingMaskIntoConstraints = false
                
                return btn
            }()
            
            buttons.append(newButton)
            newButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        }
        
    }
    @objc func buttonAction(_ sender:UIButton!)
    {
        print("Button \(sender.titleLabel!.text) tapped")
        switch sender.titleLabel!.text
        {
        case Constants.Table.services:
            showServices();
            break;
        case Constants.Table.stores:
            showStores();
            break;
        default:
            break;
        }
    }
    
    func showServices()
    {
        let vc = NewServicesTableViewController();
        self.navigationController?.show(vc, sender: nil)
    }
    func showStores()
    {
        let vc = NewStoresTableViewController();
        self.navigationController?.show(vc, sender: nil)
    }

    
}

/*
 
 override func viewDidLoad() {
 super.viewDidLoad()
 //let view = UIView()
 view.backgroundColor = .white
 
 // Create UIButton
 let myButton = UIButton(type: .system)
 
 // Position Button
 myButton.frame = CGRect(x: 20, y: 20, width: 100, height: 50)
 // Set text on button
 myButton.setTitle("Tap me", for: .normal)
 myButton.setTitle("Pressed + Hold", for: .highlighted)
 
 // Set button action
 myButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
 
 view.addSubview(myButton)
 //self.view = view
 }
 
 @objc func buttonAction(_ sender:UIButton!)
 {
 print("Button tapped")
 }
 
 */

