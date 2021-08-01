//
//  UserGroupsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserGroupsTableViewController: UITableViewController {
    private var userGroups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupsTableViewCell", for: indexPath) as! UserGroupsTableViewCell
        cell.imageGroupImageView.image = UIImage(named: userGroups[indexPath.row].image)
        cell.groupNameLabel.text = userGroups[indexPath.row].groupName
        cell.descriptionGroupLabel.text = userGroups[indexPath.row].description
        cell.countFollowGroupLabel.text = String(userGroups[indexPath.row].countFollowers)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard segue.identifier == "addGroup",
              let source = segue.source as? AllGroupsTableViewController,
              let indexPath = source.tableView.indexPathForSelectedRow else { return }
        let group = source.allGroups[indexPath.row]
        if !userGroups.contains(group){
            userGroups.append(group)
            self.tableView.reloadData()
        }
    }
}
