//
//  UserGroupsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit
import RealmSwift

class UserGroupsTableViewController: UITableViewController {
    
    private var networkSevice: NetworkService = NetworkServiceImplementation()
    private var databaseService: DatabaseService = DatabaseServiceImplementation()
    
    private lazy var groups = try? databaseService.get(RealmGroups.self)
    

    
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
                fetchGroups()
        
                notificationToken = groups?.observe { [weak self] change in
                    guard let self = self else { return }
                    switch change {
                    case .error(let error):
                        self.show(error: error)
                    case .initial: break
                    case .update:
                        self.tableView.reloadData()
                    }
                }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.invalidate()
    }
    
    private func fetchGroups() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    
        networkSevice.getGroup { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.show(error: error)
            case .success(let groupsArray):
                _ = try? self.databaseService.save(groupsArray)
                activityIndicator.stopAnimating()
            }
        }
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
    
//    @IBAction func addCityBarButton(_ sender: Any) {
//        let alertVC = UIAlertController(title: "Введите название группы:", message: nil, preferredStyle: .alert)
//
//        let saveAction = UIAlertAction(title: "Добавить", style: .default) { _ in
//            guard let textField = alertVC.textFields?.first,
//                  let groupsName = textField.text else { return }
//
//            // 1
//            let groups = FirebaseMyGroups(name: groupsName,
//                                          zipcode: Int.random(in: 100000...999999))
//            // 2
//            let groupsRef = self.ref.child(groupsName.lowercased())
//
//            groupsRef.setValue(groups.toAnyObject())
//        }
//
//        let cancelAction = UIAlertAction(title: "Отменить",
//                                         style: .cancel)
//
//        alertVC.addTextField()
//
//        alertVC.addAction(saveAction)
//        alertVC.addAction(cancelAction)
//
//        present(alertVC, animated: true, completion: nil)
//
//    }

}
