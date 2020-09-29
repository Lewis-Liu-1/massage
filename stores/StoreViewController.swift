//
//  StoreViewController.swift
//  NewMassage
//
//  Created by Lewis Liu on 17/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit

//https://youtu.be/FNrxEvtUl-U add image detail view controller

class StoreViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
      
    var store = Store()
    var imageViewArray = [UIImageView]()
    
    @IBOutlet weak var storeName: UITextField!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var storeAddress: UITextField!

    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        showImages()
        //addPlusView()
    }
    
    func showImages(){
        print("load images")
        for (index, image1) in store.images.enumerated()
        {
            print("load image")
            addImage(index:index , image: image1)
        }
        let bundle = Bundle(for: type(of: self))
        let image2 = UIImage(named: "plus", in: bundle, compatibleWith: self.traitCollection)
        addImage(index: store.images.count, image:image2!)
        imageScrollView.contentSize.width = CGFloat((store.images.count+1)*100)
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
        imageView.frame = CGRect(x: left, y: 0, width: 100, height: Int(imageScrollView.height))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        print("added image")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
        imageScrollView.addSubview(imageView)
        imageViewArray.append(imageView)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let p = tapGestureRecognizer.location(in: self.imageScrollView)
        
        for (index, image1) in self.imageViewArray.enumerated()
        {
            
            if (image1.layer.hitTest(p) != nil)  {
                print("index is \(index)")
                if index == (imageViewArray.count-1) {
                    loadImagePicker()
                }
                else{
                    presentAlert(index:index)
                }
            }
        }
        /*
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("Button capture")

                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = false

                present(imagePicker, animated: true, completion: nil)
            }
         */
    }
    
    func loadImagePicker(){
        //if tappedImage
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            print("image picked up")
            self.store.images.append(image)
            self.showImages();
        }
    }
    
    func presentAlert(index : Int)
    {
        let refreshAlert = UIAlertController(title: "Delete Image", message: "Are you sure you want to delete this image?", preferredStyle: .alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
          print("Handle Ok logic here")
          }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
          }))

        present(refreshAlert, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            print("image picked up")
            self.store.images.append(image)
        })

       
        //imageView.image = image
        //self.view.reload
    }
    @IBAction func saveTapped(_ sender: Any) {
        store.address = storeAddress.text ?? ""
        store.name = storeName.text ?? ""
        
        store.save()
        self.dismiss(animated: true, completion:nil)
        
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
