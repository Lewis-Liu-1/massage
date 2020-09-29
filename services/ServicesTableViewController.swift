//
//  ServicesTableViewController.swift
//  NewMassage
//
//  Created by Lewis Liu on 21/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit

class ServicesTableViewController: UITableViewController {
    @IBOutlet var myTableView: UITableView!
    
    var services=[Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadServices()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func loadServices()
    {
        services=[Service]()
        Service.getAll(completion: { allServices in
            self.services = allServices
            print("we got \(self.services.count)")
            print(self.services)
            
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
        return services.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // Configure the cell...
        let cellIdentifier = "ServiceTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ServiceTableViewCell  else {
            fatalError("The dequeued cell is not an instance of UserTableViewCell.")
        }
        print("store count --> \(services.count)")
        // Fetches the appropriate User for the data source layout.
        let myService = services[indexPath.row]
        cell.nameLabel.text = "\(myService.name)"
        cell.durationLabel.text = "\(myService.duration)"
        //cell.userImage.image = nil //User.photo
        //cell.ratingControl.rating = User.rating
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
            print("....delete service .... \(indexPath.row)")
            let u = services[indexPath.row]
            print("....delete service doc id.... \(u.docID)")
            Service.remove(docID: u.docID)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            //
            tableView.endUpdates()
            loadServices()
            
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
