//
//  UserGroupsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit
import RealmSwift

class UserGroupsTableViewController: UITableViewController {
    
    private var groups: Results<RealmGroups>?
    private var networkSevice: NetworkService = NetworkServiceImplementation()
    private var databaseService: DatabaseService = DatabaseServiceImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        networkSevice.getGroup { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let groupsArray):
                _ = try? self.databaseService.save(groupsArray)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        groups = try? databaseService.get(RealmGroups.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userGroups = groups else { return UITableViewCell() }
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
