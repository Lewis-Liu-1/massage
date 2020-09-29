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

class Store{
    var name = ""
    var address = ""
    var owner = ""
    var manager = ""
    var staffs = [Staff]()
    var images = [UIImage]()
    var docID = ""
    public static func getAll(completion: @escaping (([Store]) ->()))
    {
        let db = Firestore.firestore()
        db.collection(Constants.Table.stores).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var ret=[Store]()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let name=document.data()[Constants.StoreField.name]  ?? ""
                    let address=document.data()[Constants.StoreField.address]  ?? ""
                    
                    let u = Store()
                    u.name=name as! String
                    u.address=address as! String
                    
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
        db.collection(Constants.Table.stores).document(docID).delete()
    }
    
    public func save(){
        
        saveStoreInfo()
        for (index, image1) in images.enumerated()
        {
            saveImage(docID: docID, image: image1 )
        }
    }
    
    private func saveStoreInfo()
    {
        //save store general info
        var ret = ""
        let db = Firestore.firestore()
        let timestamp = NSDate().timeIntervalSince1970
        var ref: DocumentReference? = nil
        ref = db.collection(Constants.Table.stores).addDocument(
            data:[
                Constants.StoreField.name:         name,
                Constants.StoreField.address:      address,
                Constants.StoreField.owner:        owner,
                Constants.StoreField.manager:      manager,
            ])
        {
            (error) in
            if (error != nil){
                ret = error!.localizedDescription
                print(ret)
            }
            else{
                self.docID = ref!.documentID
                print("store name address saved")
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
            let newMetadata = StorageMetadata()
            newMetadata.contentType = "image/jpg";
            let imageName = NSUUID().uuidString
            
            let storageRef = Storage.storage().reference().child("images").child("\(imageName).jpg")
            
            storageRef.putData(uploadData, metadata:newMetadata, completion:
                { (metadata,error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    print(metadata)
                    print("image saved.....")
                    self.saveImgeID(docID:docID, imageName:imageName)
            })
            return imageName
        }
        return ""
    }
    
    private func saveImgeID(docID: String, imageName:String)
    {
        let db = Firestore.firestore()
        //let timestamp = NSDate().timeIntervalSince1970
        db.collection(Constants.Table.images).addDocument(
            data:[
                Constants.ImageField.table:     "Stores",
                Constants.ImageField.docID:     docID,
                Constants.ImageField.uuid:      imageName,
            ])
        {
            (error) in
            if (error != nil){
                let ret = error!.localizedDescription
                print(ret)
            }
            else{
                print("store image ref created....")
            }
        }
    }
    
}
