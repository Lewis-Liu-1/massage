//
//  Users.swift
//  NewMassage
//
//  Created by Lewis Liu on 12/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class UserInfo{
    var doc_id = ""
    var first_name = ""
    var last_name = ""
    var email = ""
    var mobile=""
    var role = ""
    var age = 0
    
    var gender = ""
    var join_date=""
    var uid = ""
    
    public static func register(_ email:String, _ password:String, completion: @escaping (AuthDataResult, Bool)->()) -> Bool{
        var Boolok = true
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password)
        { (autherResult, error) in
            guard let result = autherResult, error == nil else{
                print("user creation failed")
                Boolok = false
                completion(autherResult!,false);
                return
            }
            let user = result.user
            print("user: \(user)")
            print("user id: \(user.uid)")
            completion(result,true);
        }
        
        return Boolok
    }
    
    public static func getMyRole()->String{
        
        return Constants.Role.builder
    }
    
    public static func getMyInfo()->String
    {
        let user = FirebaseAuth.Auth.auth().currentUser
        if user != nil {
            let email = user?.email ?? ""
            return email
        }
        return ""
    }
    
    public static func save(email:String , user:UserInfo) ->String
    {
        //user created
        var ret = ""
        let db = Firestore.firestore()
        let timestamp = NSDate().timeIntervalSince1970
        db.collection(Constants.Table.users).addDocument(
            data:[
                Constants.UserField.first_name:    user.first_name,
                Constants.UserField.last_name:     user.last_name,
                Constants.UserField.email:         user.email,
                Constants.UserField.age:           user.age,
                Constants.UserField.gender:        user.gender,
                Constants.UserField.mobile:        user.mobile,
                Constants.UserField.join_date:     timestamp,
                Constants.UserField.role:          Constants.Role.customer,
                Constants.UserField.uid:           user.uid
            ])
        {
            (error) in
            if (error != nil){
                ret = error!.localizedDescription
                
            }
        }
        
        return ret
    }
    
    public static func loadUsers(completion: @escaping (([UserInfo]) ->()))
    {
        
        let db = Firestore.firestore()
        db.collection(Constants.Table.users).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var ret=[UserInfo]()
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let first_name=document.data()[Constants.UserField.first_name]  ?? ""
                    let last_name=document.data()[Constants.UserField.last_name]  ?? ""
                    let email=document.data()[Constants.UserField.email]  ?? ""
                    let uid = document.data()[Constants.UserField.uid]  ?? ""
                    
                    let u = UserInfo()
                    u.first_name=first_name as! String
                    u.last_name=last_name as! String
                    u.email=email as! String
                    u.uid = uid as! String
                    u.doc_id = document.documentID
                    ret.append(u)
                }
                completion(ret)
            }
            print("about to return result")
        }
    }
    public static func remove(doc_id: String)
    {
        //clean up
        let db = Firestore.firestore()
        db.collection(Constants.Table.users).document(doc_id).delete()
    }
    /*
     public static func fetchUsers()
     {
     let db = Firestore.firestore()
     db.collection("users").getDocuments() { (querySnapshot, err) in
     if let err = err {
     print("Error getting documents: \(err)")
     } else {
     for document in querySnapshot!.documents {
     print("\(document.documentID) => \(document.data())")
     
     let role = document.data()["role"]
     if role != nil {
     print(role!)
     }
     else{
     //clean up
     db.collection("users").document(document.documentID).delete()
     }
     }
     }
     }
     }
     */
    
    static func remove_user(uid:String) ->Bool{
        FirebaseDatabase.Database.database().reference(withPath: "User").child(uid).removeValue()
        return true
    }
    
    public static func fetchUsers1()
    {
        //let db = Firestore.firestore()
        /*FirebaseDatabase.Database.database().reference().child("users").observe(DataEventType.childAdded, with: {
         (snapshot) in
         print(snapshot)
         }, withCancel: nil)
         */
        let rootRef = Database.database().reference()
        let query = rootRef.child(Constants.Table.users) //.queryOrdered(byChild: "firstname")
        query.observeSingleEvent(of: .value) {
            (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                let value = snapshot.value as? NSDictionary
                print(value)
                //let firstname = value?["firstname"] as? String ?? ""
                //print(firstname)
            }
        }
    }
    
    public static func login(_ email:String, _ password:String) -> Bool{
        var Boolok = false
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {autherResult, error in
            guard let result = autherResult, error == nil else{
                Boolok = false
                print("user login failed")
                return
            }
            let user = result.user
            print("user logged in: \(user)")
            Boolok = true
        })
        return Boolok
    }
    
    public static func logout() -> Bool
    {
        var Boolok = true
        print("hello world")
        do{
            try FirebaseAuth.Auth.auth().signOut()
            print("user signed out")
        }catch let error{
            print("failed sign out \(error)")
            Boolok = false
        }
        return Boolok
    }
    public static func isUserLoggedin() ->Bool
    {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            return true
        }
        return false
    }
}
