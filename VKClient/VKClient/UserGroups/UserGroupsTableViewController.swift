//
//  UserGroupsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserGroupsTableViewController: UITableViewController {

    static var userGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserGroupsTableViewController.userGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupsTableViewCell", for: indexPath) as! UserGroupsTableViewCell
        
        cell.imageGroupImage.image = UIImage(named: UserGroupsTableViewController.userGroups[indexPath.row].image)
        cell.groupNameLabel.text = UserGroupsTableViewController.userGroups[indexPath.row].groupName
        cell.descriptionGroupLabel.text = UserGroupsTableViewController.userGroups[indexPath.row].description
        cell.countFollowGroupLabel.text = String(UserGroupsTableViewController.userGroups[indexPath.row].countFollowers)
       

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let group = UserGroupsTableViewController.userGroups[indexPath.row]
            UserGroupsTableViewController.userGroups.remove(at: indexPath.row)
            if !AllGroupsTableViewController.allGroups.contains(group){
            AllGroupsTableViewController.allGroups.append(group)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            
            let allGroupsTableViewController = segue.source as! AllGroupsTableViewController
            
            if let indexPath = allGroupsTableViewController.tableView.indexPathForSelectedRow {
                let group = AllGroupsTableViewController.allGroups[indexPath.row]
               if !UserGroupsTableViewController.userGroups.contains(group){
                UserGroupsTableViewController.userGroups.append(group)
                AllGroupsTableViewController.allGroups.remove(at: indexPath.row)
                    self.tableView.reloadData()
                }
            }
        }
   }

}
