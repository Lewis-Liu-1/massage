//
//  User.swift
//  FoodTracker
//
//  Created by Lewis Liu on 14/6/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit
import os.log
/*
class NOUser :NSObject , NSCoding{
    
    //MARK: Properties
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
        
    }
    
    var name: String
    var photo: UIImage?
    var rating: Int
    var email: String?
    var age: Int
    
    //MARK: Archiving Paths
     
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("users")
    
    //MARK: Initialization
    
    init?(name: String, email: String, photo: UIImage?, rating: Int, age: Int) {
        // Initialization should fail if there is no name or if the rating is negative.
        //if name.isEmpty || rating < 0  {
        //    return nil
        //}
        
        // Initialization should fail if there is no name or if the rating is negative.
        guard !name.isEmpty else{
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
 
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.email = email
        self.age = age
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a User object.", log: OSLog.default, type: .debug)
            return nil
        }
        // Because photo is an optional property of User, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        // Must call designated initializer.
        //self.init(name: name, photo: photo, rating: rating)
    }
}
*/
