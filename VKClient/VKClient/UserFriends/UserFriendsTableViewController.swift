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
    private var friends: Results<RealmFriends>?
    private var sortedFriends: Results<RealmFriends>?
    private var groupFriends = [GroupFriends]()
    private var textSearch: String = "" {
        didSet {
            groupFriendsByFirstLetter(textSearch: textSearch)
        }
    }
    private let databaseService: DatabaseService = DatabaseServiceImplementation()
    private let networkService: NetworkService =  NetworkServiceImplementation()
    
    //MARK: - LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()
        ///убираем лишние ячейки
        tableView.tableFooterView = UIView()
        setupSearchBar()
        networkService.getFriends { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let friendsArray):
                _ = try? self.databaseService.save(friendsArray)
            }
        }
        friends = try? databaseService.get(RealmFriends.self)
        groupFriendsByFirstLetter()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        searchTextField.resignFirstResponder()
    }
    
    func groupFriendsByFirstLetter(textSearch: String = ""){
        if textSearch != "" {
            sortedFriends = friends?.filter("firstName CONTAINS %@ OR lastName CONTAINS %@",
                                            textSearch, textSearch)
        } else {
            sortedFriends = friends?.sorted(byKeyPath: "firstName")
        }
        
        groupFriends.removeAll()
        
        if let sortedFriends = sortedFriends {
        for friend in sortedFriends {
            let firstLetter = String(friend.firstName.first!)
            if groupFriends.count == 0 {
                groupFriends.append(GroupFriends(firstLetter: firstLetter, friends: [friend]))
            } else {
                if firstLetter == groupFriends.last?.firstLetter {
                    groupFriends.last?.friends.append(friend)
                } else {
                    groupFriends.append(GroupFriends(firstLetter: firstLetter, friends: [friend]))
                }
            }
        }
    }
        self.tableView.reloadData()
    }
    
    ///скролл до нужно секции
    @objc private func lettersChange(_ control: LettersControl){
        let indexPath = IndexPath(item: 0, section: control.selectedLetter!)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupFriends.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupFriends[section].friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UserFriendsTableViewCell.self, for: indexPath )
        let user = self.groupFriends[indexPath.section].friends[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SegueFriendPhoto",
              let source = segue.source as? UserFriendsTableViewController,
              let destination = segue.destination as? FriendsPhotosCollectionViewController,
              let indexPath = source.tableView.indexPathForSelectedRow else { return }
        let friend = groupFriends[indexPath.section].friends[indexPath.row]
        destination.ownerId = friend.id
    }
    ///задаем название секции и перерисовываем
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.alpha = 0.5
        let label = UILabel()
        label.text = groupFriends[section].firstLetter
        label.font = UIFont(name: "Arial", size: 15)
        label.textColor = UIColor.black
        label.frame = CGRect(x: 25, y: 7, width: 100, height: 15)
        view.addSubview(label)
        return view
    }
        
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
