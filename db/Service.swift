//
//  Store.swift
//  NewMassage
//
//  Created by Lewis Liu on 18/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

class Service{
    var name = ""
    var duration = 10
    var price = 10
    var benefits = ""
    var docID=""

    var images = [UIImage]()
    
    public static func getAll(completion: @escaping (([Service]) ->()))
    {
        let db = Firestore.firestore()
        db.collection(Constants.Table.services).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var ret=[Service]()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let name=document.data()[Constants.ServiceField.name]  ?? ""
                    let duration=document.data()[Constants.ServiceField.duration]  ?? 10
                    let price=document.data()[Constants.ServiceField.price]  ?? 10
                    let benefits=document.data()[Constants.ServiceField.benefits]  ?? ""
                    
                    let u = Service()
                    u.name=name as! String
                    u.duration=duration as! Int
                    u.price=price as! Int
                    u.benefits=benefits as! String
                    u.docID = document.documentID
                    ret.append(u)
                }
                completion(ret)
            }
            print("about to return result")
        }
    }
    
    public static func remove(docID:String)
    {
        //clean up
        let db = Firestore.firestore()
        db.collection(Constants.Table.services).document(docID).delete()
    }
    
    public func save(){
        
        saveServiceInfo()
        for (index, image1) in images.enumerated()
        {
            saveImage(docID: docID, image: image1 )
        }
    }
    
    private func saveServiceInfo()
    {
        //save store general info
        var ret = ""
        let db = Firestore.firestore()
        let timestamp = NSDate().timeIntervalSince1970
        var ref: DocumentReference? = nil
        ref = db.collection(Constants.Table.services).addDocument(
            data:[
                Constants.ServiceField.name:         name,
                Constants.ServiceField.duration:      duration,
                Constants.ServiceField.price:        price,
                Constants.ServiceField.benefits:      benefits,
            ])
        {
            (error) in
            if (error != nil){
                ret = error!.localizedDescription
                print(ret)
            }
            else{
                self.docID = ref!.documentID
                print("service information saved")
            }
        }
    }
    
    func saveImage(docID: String, image : UIImage) ->String
    {
        // Get a reference to the storage service using the default Firebase App
        //let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        //let storageRef = storage.reference()
        
        if let uploadData = image.jpegData(compressionQuality:0.1) {
            // Create a child reference
            // imagesRef now points to "images"
            //let imagesRef = storageRef.child("images")
            //let newMetadata = StorageMetadata()
            //newMetadata.contentType = "image/jpg";
            let imageName = NSUUID().uuidString
            
            let storageRef = Storage.storage().reference().child("Images").child("\(imageName).jpg")
            
            storageRef.putData(uploadData, metadata:nil, completion:
                { (metadata,error) in
                    if error != nil {
                        print(error)
                        return
                    }
                    print(metadata)
                    storageRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            // Uh-oh, an error occurred!
                            return
                        }
                        print(downloadURL.absoluteString)
                        MyImages.saveImgeID(tableName: Constants.Table.services, docID:docID, imageName:imageName, url: downloadURL.absoluteString)
                    }
                    print("image saved.....")
                    
            })
            return imageName
        }
        return ""
    }
    
   
    
    
    
    public func getImagesq(completion: @escaping (([UIImage]) ->()))
    {
        let db = Firestore.firestore()
        db.collection(Constants.Table.images).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                var ret=[UIImage]()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let name = document.data()[Constants.ImageField.docID]  ?? ""
                    let table=document.data()[Constants.ImageField.table] ?? ""
                    if (table as! String) == Constants.Table.services {
                        let imageID = document.data()[Constants.ImageField.uuid]
                        let temp = document.data()[Constants.ImageField.url]
                        if temp != nil {
                            let url = temp as! String
                            let storageRef = Storage.storage().reference(forURL: url)
                            print(url)
                            storageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) -> Void in
                                // Create a UIImage, add it to the array
                                if error == nil {
                                    let pic = UIImage(data:data!)
                                    ret.append(pic!)
                                    print("...adding image")
                                    completion(ret)
                                }
                            }
                        }
                    }
                }
                completion(ret)
            }
        }
    }
}
