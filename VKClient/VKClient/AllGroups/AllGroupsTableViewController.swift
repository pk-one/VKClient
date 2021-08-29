//
//  AllGroupsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
    
    private var allGroups = Group.groupAllCases
    private let networkService: NetworkService = NetworkServiceImplementation()
    private let token = SessionInfo.shared.token!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        networkService.getGroupSearch(token: token, textSearch: "GeekBrains")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(AllGroupsTableViewCell.self, for: indexPath)
        cell.configure(with: allGroups[indexPath.row])
        return cell
    }
}

