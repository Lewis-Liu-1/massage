//
//  NewServicesTableViewController.swift
//  NewMassage
//
//  Created by Lewis Liu on 28/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit

class NewServicesTableViewController: UITableViewController {
    
    let cellId = "cellId"
    var services : [Service] = [Service]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Services"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        loadServices()
        tableView.register(NewServiceTableViewCell.self, forCellReuseIdentifier: cellId)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewServiceTableViewCell
        let currentLastItem = services[indexPath.row]
        //cell.textLabel?.text = currentLastItem.name
        cell.service = currentLastItem
        return cell
    }
    
    func loadServices()
    {
        services=[Service]()
        Service.getAll(completion: { allServices in
            self.services = allServices
            print("we got \(self.services.count)")
            print(self.services)
            
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedService = services[indexPath.row]
        print(selectedService)
        let viewController =  NewServiceViewController()
        viewController.service = selectedService
        
        self.navigationController?.pushViewController(viewController, animated:true)
    }
    
    @objc func addTapped( _ sender: UIBarButtonItem)
    {
        let viewController =  NewServiceViewController()
        viewController.service = nil
        
        //let navigat = UINavigationController()
        navigationController?.pushViewController(viewController, animated:true)
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
            tableView.deleteRows(at: [indexPath], with: .fade)
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
