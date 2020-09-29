//
//  constants.swift
//  MyMassage
//
//  Created by Lewis Liu on 2/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import Foundation

struct Constants{
    struct Storyboard{
        static let homeViewController = "homeViewController"
        static let nonMembersHomeViewController = "NonMembersViewController"
        static let membersHomeViewController = "MainTabBarController"
        static let userLoginKey = "user_email"
    }
    
    struct Role{
        static let customer="Customer"  //
        static let staff="Staff"        //
        static let manager="Manager"    //massage store manager
        static let owner="Owner"        //massage store owner
        static let builder="Creator"    //app creator
    }
    
    struct Table{
        static let users="Users"
        static let services="Services"
        static let specials="Specials"
        static let sales="Sales"
        static let stores="Stores"
        static let staffs="Staffs"
        static let images="Images"
    }
    
    struct UserField{
        static let first_name="First Name"
        static let last_name="Last Name"
        static let email="Email"
        static let mobile="Mobile"
        static let age="Age"
        static let gender="Gender"
        static let join_date="Join Date"
        static let uid="UID"
        static let role="Role"
    }
    struct StoreField{
        static let name = "Name"
        static let address = "Address"
        static let owner = "Owner"
        static let manager = "Manager"
    }
    struct ImageField{
        static let uuid="UUID"
        static let table="Table"
        static let docID="DOC ID"
        static let url = "URL"
    }
    struct ServiceField{
        static let name="Name"
        static let duration="Period"
        static let price="Price"
        static let benefits="Benefits"
    }
}
