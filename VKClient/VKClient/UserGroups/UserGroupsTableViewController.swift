//
//  UserGroupsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserGroupsTableViewController: UITableViewController {
    private var userGroups = [Group]()
    private var allGroups = Group.groupAllCases
    private var networkSevice: NetworkService = NetworkServiceImplementation()
    private let token = SessionInfo.shared.token!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        networkSevice.getGroup(token: token)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UserGroupsTableViewCell.self, for: indexPath)
        cell.configure(with: userGroups[indexPath.row])
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
        let group = allGroups[indexPath.row]
        if !userGroups.contains(group){
            userGroups.append(group)
            self.tableView.reloadData()
        }
    }
}
