//
//  UserFriendsTableViewController.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserFriendsTableViewController: UITableViewController {
    
    private var groupsUser = groupUsersByFirstLetter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///добавляем аватарку юзера в колекцию фоток
        addAvatarForCollectionPhotos()
        ///убираем лишние ячейки
        tableView.tableFooterView = UIView()
        self.navigationController?.view.addSubview(lettersControl)
        lettersControl.addTarget(self, action: #selector(lettersChange(_:)), for: .valueChanged)
    }
    
    private let lettersControl: LettersControl = {
        let lettersControl = LettersControl()
        lettersControl.translatesAutoresizingMaskIntoConstraints = false
        return lettersControl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        lettersControl.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        lettersControl.isHidden = true
    }
    ///считаем положение контрола
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let controlSize = lettersControl.bounds.size
        let xPosition = view.frame.maxX - controlSize.width
        let yPosition = view.frame.midY - (controlSize.height / 2)
        let origin = CGPoint(x: xPosition, y: yPosition)
        lettersControl.frame = CGRect(origin: origin, size: controlSize)
    }
    ///скролл до нужно секции
    @objc private func lettersChange(_ control: LettersControl){
        let indexPath = IndexPath(item: 0, section: control.selectedLetter!)
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupsUser.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsUser[section].users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserFriendsTableViewCell", for: indexPath) as! UserFriendsTableViewCell
        let user = self.groupsUser[indexPath.section].users[indexPath.row]
        cell.imageFriendImageView.image = UIImage(named: user.avatarImage)
        cell.fullNameFriendLabel.text = user.fullName
        return cell
    }
    ///задаем название секции
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupsUser[section].firstLetter
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SegueFriendPhoto",
              let source = segue.source as? UserFriendsTableViewController,
              let destination = segue.destination as? FriendsPhotosCollectionViewController,
              let indexPath = source.tableView.indexPathForSelectedRow else { return }
        let user = self.groupsUser[indexPath.section].users[indexPath.row]
        destination.photos = user.photos
    }
    ///метод добавление аватарки в коллекцию фоток
    private func addAvatarForCollectionPhotos() {
        for (_, sectionItem) in groupsUser.enumerated() {
            for (userIndex, _) in sectionItem.users.enumerated() {
                if sectionItem.users[userIndex].avatarImage != "noavatar" {
                    sectionItem.users[userIndex].photos.append(sectionItem.users[userIndex].avatarImage)
                }
            }
        }
    }
}
