//
//  UserFriendsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserFriendsTableViewController: UITableViewController {
    static var userFriends = getUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        ///добавляем аватарку юзера в колекцию фоток
        for (index, element) in UserFriendsTableViewController.userFriends.enumerated() {
            UserFriendsTableViewController.userFriends[index].photos.append(element.avatarImage)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserFriendsTableViewController.userFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserFriendsTableViewCell", for: indexPath) as! UserFriendsTableViewCell
        cell.imageFriendImage.image = UIImage(named: UserFriendsTableViewController.userFriends[indexPath.row].avatarImage)
        cell.fullNameFriendLabel.text = UserFriendsTableViewController.userFriends[indexPath.row].fullName
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SegueFriendPhoto" else { return }
        guard let source = segue.source as? UserFriendsTableViewController else { return }
        guard let destination = segue.destination as? FriendsPhotosCollectionViewController else { return }
        if let indexPath = source.tableView.indexPathForSelectedRow {
            destination.userID = indexPath.row
        }
    }
}
