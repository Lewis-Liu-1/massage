//
//  UsersTableViewController.swift
//  NewMassage
//
//  Created by Lewis Liu on 14/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    @IBOutlet var myTableView: UITableView!
    
    var localUsers=[UserInfo]()
    
    override func viewDidLoad() {
        
        loadUsers()
        super.viewDidLoad()
        //navigationItem.leftBarButtonItem = editButtonItem
        
        //loadSampleUsers()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func loadUsers()
    {
        localUsers=[UserInfo]()
        UserInfo.loadUsers(completion: { alluser in
            self.localUsers = alluser
            print("we got \(self.localUsers.count)")
            print(self.localUsers)
            
            self.myTableView.reloadData()
        })
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("ww user count --> \(localUsers.count)")
        return localUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "UserTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? UserTableViewCell  else {
            fatalError("The dequeued cell is not an instance of UserTableViewCell.")
        }
        print("user count --> \(localUsers.count)")
        // Fetches the appropriate User for the data source layout.
        let User = localUsers[indexPath.row]
        cell.nameLabel.text = "\(User.first_name), \(User.last_name)"
        cell.emailLabel.text = User.email
        //cell.userImage.image = nil //User.photo
        //cell.ratingControl.rating = User.rating
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            print("....delete user .... \(indexPath.row)")
            let u = localUsers[indexPath.row]
            print("....delete user doc id.... \(u.doc_id)")
            UserInfo.remove(doc_id: u.doc_id)
            tableView.deleteRows(at: [indexPath], with: .fade)
            loadUsers()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("show user detail....")
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        print("hi")
        self.dismiss(animated: true, completion:nil)
    }
    /*
     private func loadSampleUsers() {
     let photo1 = UIImage(named: "filledStar")
     let photo2 = UIImage(named: "emptyStar")
     let photo3 = UIImage(named: "highlightedStar")
     guard let User1 = User(name: "Caprese Salad", photo: photo1, rating: 4) else {
     fatalError("Unable to instantiate User1")
     }
     
     guard let User2 = User(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
     fatalError("Unable to instantiate User2")
     }
     
     guard let User3 = User(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
     fatalError("Unable to instantiate User2")
     }
     users += [User1, User2, User3]
     
     }
     */
    
}
