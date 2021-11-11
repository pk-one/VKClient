//
//  UserGroupsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit
import RealmSwift

class UserGroupsTableViewController: UITableViewController {
    
    private var databaseService: DatabaseService = DatabaseServiceImplementation()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var groups: Results<RealmGroups>? {
        didSet {
            activityIndicator.stopAnimating()
        }
    }
    
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
                fetchGroups()
        
                notificationToken = groups?.observe { [weak self] change in
                    switch change {
                    case .error(let error):
                        self?.show(error: error)
                    case .initial:
                        self?.tableView.reloadData()
                    case .update:
                        self?.tableView.reloadData()
                    }
                }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.invalidate()
    }
    
    private func fetchGroups() {
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        
        groups = try? databaseService.get(RealmGroups.self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let groups = groups else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(UserGroupsTableViewCell.self, for: indexPath)
        cell.configure(with: groups[indexPath.row])
        return cell
    }
}
