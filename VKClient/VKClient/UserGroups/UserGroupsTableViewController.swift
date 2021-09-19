//
//  UserGroupsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserGroupsTableViewController: UITableViewController {
    
    private lazy var userGroups = try? databaseService.get(RealmGroups.self)
    private var networkSevice: NetworkService = NetworkServiceImplementation()
    private var databaseService: DatabaseService = DatabaseServiceImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        networkSevice.getGroup()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userGroups = userGroups else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(UserGroupsTableViewCell.self, for: indexPath)
        cell.configure(with: userGroups[indexPath.row])
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            userGroups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//        }
//    }
}
