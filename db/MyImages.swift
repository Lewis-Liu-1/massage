//
//  Images.swift
//  NewMassage
//
//  Created by Lewis Liu on 7/8/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

class MyImages
{
    public static func saveImgeID(tableName: String, docID: String, imageName:String, url: String)
    {
        let db = Firestore.firestore()
        //let timestamp = NSDate().timeIntervalSince1970
        db.collection(Constants.Table.images).addDocument(
            data:[
                Constants.ImageField.table:     tableName,
                Constants.ImageField.docID:     docID,
                Constants.ImageField.uuid:      imageName,
                Constants.ImageField.url:       url,
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
    
    /*
    public static func getImages(tableName:String, docID :String) ->[String]
    {
        var ret : [String] = [String]()
        let db = Firestore.firestore()
        var documents = db.collection(Constants.Table.images).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            for document in querySnapshot!.documents {
                print("\(document.documentID) => \(document.data())")
                let url = document.data()[Constants.ImageField.url]
                let tempDocID=document.data()[Constants.ImageField.docID] as! String
                if tempDocID == docID && url != nil{
                    print("Adding ...")
                    ret.append(url as! String)
                }
            }
        }
        print("Total \(ret.count)")
        return ret
    }
    */
    
    /*
    public func getImagesgetImages(tableName:String, docID :String) -> [UIImage]
    {
        var ret : [UIImage] = [UIImage]()
        let db = Firestore.firestore()
        var documents = db.collection(Constants.Table.images).getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
            return
        }
        
        for document in querySnapshot!.documents {
                //print("\(document.documentID) => \(document.data())")
                let temp = document.data()[Constants.ImageField.url]
                let xx = temp as! String
                let url = URL(string:xx)!
                do {
                    let myData = try NSData(contentsOf: url, options: [.alwaysMapped , .uncached ])
                    ret.append(UIImage(data: myData as Data)!)
                    print("......found image")
                    catch {
                        print(error)
                    }
                }
            }
        }
        
        print("total \(ret.count)")
        return ret
    }*/
    
    
    public func getImages(tableName:String, docID :String, completion: @escaping ((UIImage) ->()))
    {
        let db = Firestore.firestore()
        db.collection(Constants.Table.images).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            for document in querySnapshot!.documents {
                print("\(document.documentID) => \(document.data())")
                let documentID = document.data()[Constants.ImageField.docID] as! String
                let table = document.data()[Constants.ImageField.table] as! String
                if table == tableName && documentID == docID {
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
                                completion(pic!)
                                print("...adding image")
                            }
                        }
                    }
                }
            }
        }
    }
    
    public func getImages(table:String, uid:String)->[UIImage]
    {
        var ret=[UIImage]()
        
        let db = Firestore.firestore()
        db.collection(Constants.Table.images).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
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
                                //completion(ret)
                            }
                        }
                    }
                }
            }
            //completion(ret)
        }
        
        return ret
    }
}
