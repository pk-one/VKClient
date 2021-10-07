//
//  UserFriendsTableViewCell.swift
//  VKClient
//
//  Created by Pavel Olegovich on 25.07.2021.
//

import UIKit

class UserFriendsTableViewCell: UITableViewCell {
    @IBOutlet private var imageFriendImageView: RoundedImageView!
    @IBOutlet private var fullNameFriendLabel: UILabel!
    @IBOutlet private var cityFriendLabel: UILabel!
    @IBOutlet var userOnlineImageView: UIImageView!
    
    func configure(with friend: RealmFriends) {
        let url = URL(string: friend.avatar)
        imageFriendImageView.kf.setImage(with: url)
        fullNameFriendLabel.text = "\(friend.firstName) \(friend.lastName)"
        cityFriendLabel.text = friend.city
        
        if friend.online == 1 {
            userOnlineImageView.isHidden = false
        }
    }
}


