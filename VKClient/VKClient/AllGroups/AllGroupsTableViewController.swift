//
//  AllGroupsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
    static var allGroups = getAllGroups()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AllGroupsTableViewController.allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsTableViewCell", for: indexPath) as! AllGroupsTableViewCell
        cell.imageGroupImage.image = UIImage(named: AllGroupsTableViewController.allGroups[indexPath.row].image)
        cell.nameGroupLabel.text = AllGroupsTableViewController.allGroups[indexPath.row].groupName
        cell.descriptionGroupLabel.text = AllGroupsTableViewController.allGroups[indexPath.row].description
        cell.countFollowGroupLabel.text = String(AllGroupsTableViewController.allGroups[indexPath.row].countFollowers)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AllGroupsTableViewController.allGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }
}
