//
//  UserFriendsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import Foundation
import UIKit
import RealmSwift

class UserFriendsTableViewController: UITableViewController {
    //MARK: - Outlets
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var cancelSearchButton: UIButton!
    @IBOutlet var centerXContraintMagnifyingGlass: NSLayoutConstraint!
    @IBOutlet var trailingConstraintSearchTextField: NSLayoutConstraint!
    
    //MARK: - Properties
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var friends: [FriendsItems]? {
        didSet {
            activityIndicator.stopAnimating()
        }
    }
    private var sortedFriends: [FriendsItems]?
    private var groupFriends: [GroupFriends] = []
    private var textSearch: String = "" {
        didSet {
            groupFriendsByFirstLetter(textSearch: textSearch)
        }
    }
    
    private var friendsAdapter = FriendsAdapter()
    private let viewModelFactory = FriendsViewModelFactory()
    
    private var friendViewModel: [FriendsViewModel] = []
    
    //MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        ///убираем лишние ячейки
        tableView.tableFooterView = UIView()
        setupSearchBar()
        fetchFriends()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFriends()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        searchTextField.resignFirstResponder()
    }
    
    private func fetchFriends() {
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        
        friendsAdapter.getFriends { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friends):
                self.friends = friends
                self.friendViewModel = self.viewModelFactory.constructViewModel(from: friends)
                self.groupFriendsByFirstLetter()
                self.activityIndicator.stopAnimating()
                
            case .failure(let error):
                self.show(error: error)
            }
        }
    }
    
    func groupFriendsByFirstLetter(textSearch: String = ""){
        if textSearch != "" { sortedFriends = friends?.filter { $0.firstName == textSearch || $0.lastName == textSearch }
        } else {
            sortedFriends = friends?.sorted(by: { $0.firstName < $1.firstName })
        }
        
//        groupFriends.removeAll()
        
//        if let sortedFriends = sortedFriends {
//            for friend in sortedFriends {
//                let firstLetter = String(friend.firstName.first!)
//                if groupFriends.count == 0 {
//                    groupFriends.append(GroupFriends(firstLetter: firstLetter, friends: [friend]))
//                } else {
//                    if firstLetter == groupFriends.last?.firstLetter {
//                        groupFriends.last?.friends.append(friend)
//                    } else {
//                        groupFriends.append(GroupFriends(firstLetter: firstLetter, friends: [friend]))
//                    }
//                }
//            }
//        }

        self.tableView.reloadData()
    }
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UserFriendsTableViewCell.self, for: indexPath )
//        let user = self.groupFriends[indexPath.section].friends[indexPath.row]
        cell.configure(with: friendViewModel[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SegueFriendPhoto",
              let source = segue.source as? UserFriendsTableViewController,
              let destination = segue.destination as? FriendsPhotosCollectionViewController,
              let indexPath = source.tableView.indexPathForSelectedRow else { return }
        let friend = friendViewModel[indexPath.row]
        destination.ownerId = friend.id
    }
//    ///задаем название секции и перерисовываем
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .lightGray
//        view.alpha = 0.5
//        let label = UILabel()
//        label.text = groupFriends[section].firstLetter
//        label.font = .arial15()
//        label.textColor = .standardBlack
//        label.frame = CGRect(x: 25, y: 7, width: 100, height: 15)
//        view.addSubview(label)
//        return view
//    }
        
    private func setupSearchBar() {
        searchTextField.addTarget(self, action: #selector(editingBegan(_:)), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        cancelSearchButton.addTarget(self, action: #selector(touchCancel(_:)), for: .touchUpInside)
    }
    
    @objc private func editingBegan(_ textField: UITextField) {
        let widthSearchField = searchTextField.bounds.size.width
        let widthCancelButton = cancelSearchButton.bounds.size.width

        UIView.animate(withDuration: 0.3) {
            self.trailingConstraintSearchTextField.constant += 70
        }
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.centerXContraintMagnifyingGlass.constant += (widthSearchField / 2) - widthCancelButton - 30
                        self.view.layoutIfNeeded()
                       })
        UIView.animate(withDuration: 0.5, delay: 0.3) {
            self.cancelSearchButton.alpha = 1
        }
    }
    
    @objc private func touchCancel(_ sender: UIButton) {
        let widthSearchField = searchTextField.bounds.size.width
        let widthCancelButton = cancelSearchButton.bounds.size.width

        UIView.animate(withDuration: 0.3, animations: {
            self.cancelSearchButton.alpha = 0
            self.textSearch = ""
            self.searchTextField.text = ""
            self.searchTextField.resignFirstResponder()
            self.tableView.reloadData()
        }) {_ in
            UIView.animate(withDuration: 0.3) {
                self.trailingConstraintSearchTextField.constant -= 70
            }
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
                            self.centerXContraintMagnifyingGlass.constant -= widthSearchField / 2 - widthCancelButton + 5
                            self.view.layoutIfNeeded()
                           })
        }
    }
    
    @objc private func editingChanged(_ sender: UITextField) {
        guard searchTextField.text != "" else { return }
        self.textSearch = searchTextField.text!
        self.tableView.reloadData()
    }
}
