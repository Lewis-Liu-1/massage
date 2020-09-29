//
//  NewServiceViewController.swift
//  NewMassage
//
//  Created by Lewis Liu on 30/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit

class NewServiceViewController: UIViewController {
    //setup standard variables
    let labelOne: UILabel = {
        let label = UILabel()
        label.text = UserInfo.getMyInfo()
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelTwo: UILabel = {
        let label = UILabel()
        label.text = UserInfo.getMyInfo()
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mainView: UIStackView=UIStackView()
    
    //end set up standard variables
    
    var service : Service?
    
    var nameField: UITextField!
    var durationField: UITextField!
    var priceField: UITextField!
    var benefitField: UITextView!
    
    var imageScrollView: UIScrollView = UIScrollView()
    
    var images = [UIImage]()
    var imgURLs = [String]()
    var imageViewArray = [UIImageView]()
    
    var lastItemAnchor: NSLayoutYAxisAnchor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let role = UserInfo.getMyRole()
        switch(role)
        {
        case Constants.Role.builder:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
            break;
        case Constants.Role.customer:
            print("boo")
            //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
            let btn2 = UIButton(type: .custom)
            btn2.titleLabel?.text = "Book A Service"
            btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn2.addTarget(self, action: #selector(bookService), for: .touchUpInside)
            let button1 = UIBarButtonItem(customView: btn2) // action:#selector(Class.MethodName) for swift 3
            self.navigationItem.rightBarButtonItem  = button1
            break;
        default:
            print("why")
            break;
        }
    }
    
    @objc func bookService()
    {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        clearScreen()
        setupMainScrollView()
        addTextFields()
        
        lastItemAnchor = benefitField.bottomAnchor
        addImageCollections()
    }
    
    func clearScreen()
    {
        view.subviews.forEach({ $0.removeFromSuperview() }) // this gets things done
        view.subviews.map({ $0.removeFromSuperview() }) // this returns modified array
        
        self.imageViewArray.removeAll(keepingCapacity: false)
        
    }
    
    func addTextFields()
    {
        nameField = UITextField()
        nameField.placeholder = "Service Name"
        nameField.text = service?.name
        
        durationField = UITextField()
        durationField.placeholder = "Duration"
        if (service != nil) {
            durationField.text = "\(service!.duration)"
        }
        
        priceField = UITextField()
        priceField.placeholder = "Price"
        if (service != nil) {
            priceField.text = "\(service!.price)"
        }
        
        benefitField = UITextView()
        if service != nil {
            benefitField.text = service?.benefits
        }
        let views = [nameField, durationField, priceField, benefitField]
        addConstraints(views:views)
    }
    
    func addImageCollections()
    {
        mainView.addSubview(imageScrollView)
        imageScrollView.translatesAutoresizingMaskIntoConstraints=false
        
        imageScrollView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //imageScrollView.widthAnchor.constraint(equalToConstant: 1000).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 20).isActive=true
        imageScrollView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,constant: -20).isActive=true
        imageScrollView.topAnchor.constraint(equalTo: lastItemAnchor , constant: 10).isActive=true
        
        imageScrollView.backgroundColor = .yellow
        
        imageScrollView.contentSize = CGSize(width: 1000, height: 100)
        
        showImages()
        
        let btn = UIButton(type:.system)
        btn.backgroundColor = .brown
        btn.setTitleColor(UIColor.black, for: .normal)
        //btn.setTitleColor(UIColor.blue, for: .highlighted)
        btn.setTitle("Add Image", for: .normal)
        //btn.tintColor = .black
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(btn)
        btn.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 10).isActive = true
        btn.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor).isActive = true
        btn.addTarget(self, action: #selector(addImageBtnTapped(_:)), for: .touchUpInside)
        
    }
    
    func showImages(){
        print("load images")
        MyImages().getImages(tableName: Constants.Table.services, docID: service?.docID as! String, completion: { data in
            self.addImage(index:self.imageViewArray.count , image: data)
            self.imageScrollView.contentSize.width = CGFloat((self.imageViewArray.count+1)*100)
        })
        //let bundle = Bundle(for: type(of: self))
        //let image2 = UIImage(named: "plus", in: bundle, compatibleWith: self.traitCollection)
        //addImage(index: images.count, image:image2!)
    }
    
    func addImage(index:Int, image: UIImage)
    {
        let imageView = UIImageView()
        imageView.layer.borderColor = .init(srgbRed: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        imageView.layer.cornerRadius = 5.0
        imageView.layer.borderWidth = 2
        
        //var image = UIImage(named: "plus", in: bundle, compatibleWith: self.traitCollection)
        //image.rec CGRectMake(10.0, 10.0, 25.0, 25.0)
        imageView.image = image
        let left = (index * 100) as Int
        imageView.frame = CGRect(x: left, y: 0, width: 100, height: 100)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        print("added image")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageScrollView.addSubview(imageView)
        imageViewArray.append(imageView)
    }
    
    func setupMainScrollView()
    {
        view.backgroundColor = .white
        
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        
        self.view.addSubview(labelOne)
        
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 90, width: screenWidth, height: screenHeight))
        
        scrollView.addSubview(labelTwo)
        labelTwo.translatesAutoresizingMaskIntoConstraints=false
        labelTwo.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        scrollView.contentSize = CGSize(width: screenWidth, height: 1000)
        view.addSubview(scrollView)
        
        scrollView.addSubview(mainView)
        mainView.backgroundColor = .white
        scrollView.backgroundColor = .lightGray
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        mainView.topAnchor.constraint(equalTo: labelTwo.bottomAnchor, constant: 10).isActive = true
        mainView.spacing = 10
        
        labelTwo.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 20).isActive = true
        labelTwo.rightAnchor.constraint(equalTo:view.rightAnchor, constant: -20).isActive = true
        
        mainView.alignment = .fill
        mainView.distribution = .fillEqually
        mainView.spacing = 8.0
    }
    
    func addConstraints(views: [UIView?])
    {
        let top = labelTwo.bottomAnchor// NSLayoutYAxisAnchor(). view.topAnchor + 40
        var i = 0.0
        for v in views{
            if v is UITextField {
                let vv = v as! UITextField
                vv.backgroundColor = .white
                vv.borderStyle = .roundedRect
                mainView.addSubview(v!)
                let label = UILabel()
                label.text = vv.placeholder
                label.clipsToBounds = true
                mainView.addSubview(label)
                label.translatesAutoresizingMaskIntoConstraints=false
                label.topAnchor.constraint(equalTo:top, constant: CGFloat(60.0 * i)).isActive = true
                label.leftAnchor.constraint(equalTo:mainView.leftAnchor, constant:20).isActive = true
                label.rightAnchor.constraint(equalTo:mainView.rightAnchor, constant:-20).isActive = true
                
                vv.clipsToBounds = true
                vv.translatesAutoresizingMaskIntoConstraints = false
                vv.topAnchor.constraint(equalTo:label.bottomAnchor, constant: CGFloat(5)).isActive = true
                vv.leftAnchor.constraint(equalTo:mainView.leftAnchor, constant:20).isActive = true
                vv.rightAnchor.constraint(equalTo:mainView.rightAnchor, constant:-20).isActive = true
            }
            
            if v is UITextView{
                let yy = v as! UITextView
                yy.backgroundColor = .white
                //yy.borderStyle = .roundedRect
                mainView.addSubview(yy)
                let label = UILabel()
                label.text = "Benefits"
                label.clipsToBounds = true
                mainView.addSubview(label)
                label.translatesAutoresizingMaskIntoConstraints=false
                label.topAnchor.constraint(equalTo:top, constant: CGFloat(60.0 * i)).isActive = true
                label.leftAnchor.constraint(equalTo:mainView.leftAnchor, constant:20).isActive = true
                label.rightAnchor.constraint(equalTo:mainView.rightAnchor, constant:-20).isActive = true
                
                yy.clipsToBounds = true
                yy.translatesAutoresizingMaskIntoConstraints = false
                yy.topAnchor.constraint(equalTo:label.bottomAnchor, constant: CGFloat(5)).isActive = true
                yy.leftAnchor.constraint(equalTo:mainView.leftAnchor, constant:20).isActive = true
                yy.rightAnchor.constraint(equalTo:mainView.rightAnchor, constant:-20).isActive = true
                yy.heightAnchor.constraint(equalToConstant: 100).isActive = true
            }
            i = i + 1
        }
    }
    
    @objc func saveTapped( _ sender: UIBarButtonItem)
    {
        if service == nil {
            service = Service()
        }
        service?.price = Int(priceField.text ?? "10") ?? 10
        service?.name = nameField.text ?? ""
        service?.duration = Int(durationField.text ?? "10") ?? 10
        service?.benefits = benefitField.text ?? ""
        service?.images = self.images
        
        service?.save()
        Utilities.showAlert(view: self, title: "Add Service", message: "Information Saved")
    }
    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
        
    }
    
    func showFullImageView(sender: UIImageView)
    {
        let vc = ImageViewController()
        vc.imgView = sender
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showFullImage(sender: UIImageView)
    {
        let imageView = sender
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func addImageBtnTapped(_ sender:UIButton!)
    {
        loadImagePicker()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let p = tapGestureRecognizer.location(in: self.imageScrollView)
        
        print("total: \(self.imageViewArray.count)")
        for (index, image1) in self.imageViewArray.enumerated()
        {
            
            if (image1.layer.hitTest(p) != nil)  {
                print("index is \(index)")
                
                showFullImage(sender:image1)
                break
            }
        }
    }
    func loadImagePicker(){
        //if tappedImage
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            print("image picked up")
            self.images.append(image)
            self.addImage(index: self.imageViewArray.count, image: image)
           
        }
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
