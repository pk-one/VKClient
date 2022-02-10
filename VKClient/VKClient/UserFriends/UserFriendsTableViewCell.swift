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
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var userOnlineImageView: UIImageView!
    
    func configure(with friend: RealmFriends) {
        let url = URL(string: friend.avatar)
        imageFriendImageView.kf.setImage(with: url)
        cityNameLabel.text = friend.city
        fullNameFriendLabel.text = "\(friend.firstName) \(friend.lastName)"
        
        if friend.online == 1 {
            userOnlineImageView.isHidden = false
        }
    }
}


